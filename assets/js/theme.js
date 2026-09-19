// Colour theme: auto (system) → light → dark, remembered per browser.
const btn = document.getElementById("theme");
const LABEL = { auto: "◐ Auto", light: "☀ Light", dark: "☾ Dark" };
function setTheme(t, save = true) {
  if (t === "auto") delete document.documentElement.dataset.theme;
  else document.documentElement.dataset.theme = t;
  btn.textContent = LABEL[t];
  btn.setAttribute("aria-label", `Colour theme: ${t}. Click to change.`);
  if (save) try { localStorage.setItem("theme", t); } catch {}
}
if (btn) {
  setTheme(document.documentElement.dataset.theme ?? "auto", false);
  btn.addEventListener("click", () => {
    const order = ["auto", "light", "dark"];
    setTheme(order[(order.indexOf(document.documentElement.dataset.theme ?? "auto") + 1) % 3]);
  });
}
