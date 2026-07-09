/* ============================================================
   Fullerton College (FC) Report Template — TOC Scroll Spy
   Package:      fctools
   Template:     report
   Version:      1.0.0

   Highlights the active section in #toc as the reader scrolls.
   ============================================================ */

document.addEventListener("DOMContentLoaded", () => {

  const toc = document.querySelector("#toc");

  if (!toc) return;

  const links = Array.from(toc.querySelectorAll("a"));

  const headings = links
    .map(link =>
      document.getElementById(
        decodeURIComponent(link.hash.slice(1))
      )
    )
    .filter(Boolean);

  function updateTOC() {

    let activeIndex = -1;

    for (let i = 0; i < headings.length; i++) {

      if (headings[i].getBoundingClientRect().top <= 140) {
        activeIndex = i;
      } else {
        break;
      }

    }

    links.forEach(link =>
      link.classList.remove("active")
    );

    toc.querySelectorAll("li").forEach(li =>
      li.classList.remove("active-parent")
    );

    if (activeIndex >= 0) {

      const activeLink = links[activeIndex];

      activeLink.classList.add("active");

      let li = activeLink.closest("li");

      while (li && li.parentElement !== toc) {

        li.classList.add("active-parent");

        li = li.parentElement.closest("li");

      }

    }

  }

  document.addEventListener(
    "scroll",
    updateTOC,
    { passive: true }
  );

  updateTOC();

});