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