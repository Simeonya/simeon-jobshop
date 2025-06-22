let basket = [];

window.addEventListener('message', function (event) {
  const data = event.data;

  if (data.action === 'openShop') {
    const container = document.querySelector('.shop-container');
    const itemsWrapper = document.getElementById('shop-items');

    container.style.display = 'flex';
    itemsWrapper.innerHTML = '';
    basket = [];
    updateCart();

    data.items.forEach(item => {
      const div = document.createElement('div');
      div.className = 'shop-item';

      div.innerHTML = `
        <div>
            <div class="label">${item.label}</div>
            <div class="price">${item.price} €</div>
        </div>
        <div style="display: flex; gap: 10px; align-items: center;">
            <input type="number" min="1" max="100" value="1" class="item-qty" data-name="${item.name}" data-price="${item.price}" data-label="${item.label}">
            <button class="add-to-basket" data-name="${item.name}" data-price="${item.price}" data-label="${item.label}">Hinzufügen</button>
        </div>
      `;
      itemsWrapper.appendChild(div);
    });
  }
});

function updateCart() {
  const cartList = document.getElementById('cart-list');
  const totalItems = document.getElementById('cart-total-items');
  const totalPrice = document.getElementById('cart-total-price');

  cartList.innerHTML = '';
  let totalCount = 0;
  let totalCost = 0;

  basket.forEach(item => {
    const li = document.createElement('li');
    li.innerHTML = `${item.label} x${item.count} <span style="cursor:pointer; color:#ff5555;" onclick="removeFromCart('${item.name}')">✖</span>`;
    cartList.appendChild(li);
    totalCount += item.count;
    totalCost += item.count * item.price;
  });

  totalItems.innerText = `${totalCount} Artikel`;
  totalPrice.innerText = `${totalCost} €`;
}

function removeFromCart(name) {
  basket = basket.filter(item => item.name !== name);
  updateCart();
}

document.addEventListener('click', function (e) {
  if (e.target.classList.contains('add-to-basket')) {
    const name = e.target.dataset.name;
    const label = e.target.dataset.label;
    const price = parseInt(e.target.dataset.price);

    const qtyInput = document.querySelector(`.item-qty[data-name="${name}"]`);
    let qty = parseInt(qtyInput?.value) || 1;

    const existing = basket.find(b => b.name === name);

    if (existing) {
      if (existing.count + qty > 100) {
        emitNotification("Du kannst maximal 100 Stück von diesem Artikel kaufen.");
        return;
      }
      existing.count += qty;
    } else {
      if (qty > 100) {
        qty = 100;
        emitNotification("Maximal 100 Stück erlaubt. Menge wurde angepasst.");
      }
      basket.push({ name, label, price, count: qty });
    }

    emitNotification(`${label} hinzugefügt (${qty}x).`);
    updateCart();
  }

  if (e.target.classList.contains('submit-btn')) {
    if (basket.length === 0) {
      emitNotification("Warenkorb ist leer.");
      return;
    }

    fetch(`https://${GetParentResourceName()}/buyBasket`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ items: basket })
    }).then(() => {
      emitNotification("Einkauf abgeschlossen.");
    });

    basket = [];
    updateCart();
    document.querySelector('.shop-container').style.display = 'none';
    fetch(`https://${GetParentResourceName()}/close`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({})
    });
  }
});

document.addEventListener('keydown', function (e) {
  if (e.key === 'Escape') {
    document.querySelector('.shop-container').style.display = 'none';
    fetch(`https://${GetParentResourceName()}/close`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({})
    });
  }
});

function emitNotification(msg) {
  fetch(`https://${GetParentResourceName()}/notify`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ message: msg })
  });
}
