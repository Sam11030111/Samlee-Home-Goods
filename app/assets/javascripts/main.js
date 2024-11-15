// Immediately Invoked Function Expression (IIFE)
(function() {
    // BURGERS
    const $burgers = document.querySelectorAll(".js-burger");
  
    $burgers.forEach((el) => {
      el.addEventListener("click", (e) => {
        e.preventDefault();
        const targetID = el.dataset.target;
        const $target = document.getElementById(targetID);
        el.classList.toggle("is-active");
        $target.classList.toggle("is-active");
        e.stopPropagation();
      });
    });
})();

// Credit card input
document.addEventListener("DOMContentLoaded", function () {
  const cardNumberInput = document.querySelector(".card-number input");
  const monthInput = document.querySelector(".card-expire-month input");
  const yearInput = document.querySelector(".card-expire-year input");
  const cvvInput = document.querySelector(".card-cvv input");

  cardNumberInput.addEventListener("input", function (e) {
    // Remove non-numeric characters and limit to 16 digits
    let value = e.target.value.replace(/\D/g, '').substring(0, 16);

    // Format for display: Add a space every 4 digits
    e.target.value = value.replace(/(\d{4})(?=\d)/g, "$1 ");

    // Prevent cursor from jumping when adding spaces
    const cursorPosition = e.target.selectionEnd;
    e.target.setSelectionRange(cursorPosition, cursorPosition);
  });

  monthInput.addEventListener("input", function (e) {
    e.target.value = e.target.value.replace(/\D/g, '').substring(0, 2);
  });

  yearInput.addEventListener("input", function (e) {
    e.target.value = e.target.value.replace(/\D/g, '').substring(0, 4);
  });

  cvvInput.addEventListener("input", function (e) {
    e.target.value = e.target.value.replace(/\D/g, '').substring(0, 3);
  });
});