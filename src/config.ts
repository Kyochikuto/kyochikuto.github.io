import type { Site, SocialObjects } from "./types";

export const SITE: Site = {
  website: "https://kyochikuto.pages.dev/",
  author: "Kyōchikutō | キョウチクトウ",
  desc: "از تجربیات و یافته هام در زمینه شبکه و نرم‌افزار می‌نویسم",
  title: "یادداشت های کیوچیکوتو",
  ogImage: "astropaper-og.jpg",
  lightAndDarkMode: true,
  postPerPage: 3,
  scheduledPostMargin: 15 * 60 * 1000, // 15 minutes
};

export const LOCALE = {
  lang: "fa",
  langTag: ["fa-IR"],
} as const;

export const LOGO_IMAGE = {
  enable: false,
  svg: true,
  width: 216,
  height: 46,
};

export const SOCIALS: SocialObjects = [
  {
    name: "Github",
    href: "https://github.com/kyochikuto",
    linkTitle: `در گیت‌هاب ${SITE.author}`,
    active: true,
  },
  {
    name: "Twitter",
    href: "https://github.com/0xKyochikuto",
    linkTitle: `در توییتر ${SITE.author}`,
    active: true,
  },
];
