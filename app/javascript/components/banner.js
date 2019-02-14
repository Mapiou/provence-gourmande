import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["La Provence gourmande", "La Provence délicieuse", "La Provence passionnée"],
    typeSpeed: 100,
    loop: true
  });
};

export { loadDynamicBannerText };
