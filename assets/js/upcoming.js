(function () {
  function updateUpcoming() {
    var now = new Date();
    var today = [
      now.getFullYear(),
      String(now.getMonth() + 1).padStart(2, '0'),
      String(now.getDate()).padStart(2, '0')
    ].join('-');

    document.querySelectorAll('[data-upcoming-date]').forEach(function (label) {
      label.hidden = label.getAttribute('data-upcoming-date') <= today;
    });
  }

  updateUpcoming();
  document.addEventListener('visibilitychange', function () {
    if (!document.hidden) updateUpcoming();
  });
}());
