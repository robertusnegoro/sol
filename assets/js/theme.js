(function () {
  var STORAGE_KEY = 'theme';
  var root = document.documentElement;

  function getSystemTheme() {
    if (typeof window.matchMedia !== 'undefined' && window.matchMedia('(prefers-color-scheme: dark)').matches) {
      return 'dark';
    }
    return 'light';
  }

  function resolveTheme(stored) {
    if (stored === 'auto' || !stored) return getSystemTheme();
    return stored;
  }

  function applyTheme(theme) {
    var resolved = resolveTheme(theme);
    root.setAttribute('data-theme', resolved);
    root.setAttribute('data-theme-preference', theme || 'auto');
  }

  function init() {
    var stored = localStorage.getItem(STORAGE_KEY);
    applyTheme(stored);
  }

  function cycleTheme() {
    var resolved = root.getAttribute('data-theme') || getSystemTheme();
    var next = resolved === 'dark' ? 'light' : 'dark';
    localStorage.setItem(STORAGE_KEY, next);
    applyTheme(next);
  }

  init();

  if (typeof window.matchMedia !== 'undefined') {
    window.matchMedia('(prefers-color-scheme: dark)').addListener(function () {
      var pref = root.getAttribute('data-theme-preference');
      if (pref === 'auto' || !pref) applyTheme('auto');
    });
  }

  window.themeCycle = cycleTheme;

/* Back to top */
(function () {
  var btn = document.getElementById('back-to-top');
  if (!btn) return;
  function toggle() {
    btn.classList.toggle('visible', window.pageYOffset > 300);
  }
  window.addEventListener('scroll', toggle, { passive: true });
  toggle();
  btn.addEventListener('click', function () {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });
})();
})();
