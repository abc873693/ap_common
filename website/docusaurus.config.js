/** @type {import('@docusaurus/types').DocusaurusConfig} */
module.exports = {
  title: '校務通系列共用工程',
  tagline: '史上最強大校務系統 App',
  url: 'https://ap-common.web.app',
  baseUrl: '/',
  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',
  favicon: 'img/favicon.ico',
  organizationName: 'AP-Common', // Usually your GitHub org/user name.
  projectName: 'AP-Common', // Usually your repo name.
  themeConfig: {
    navbar: {
      title: '校務通系列共用工程',
      logo: {
        alt: 'My Site Logo',
        src: 'img/logo.svg',
      },
      items: [
        {
          type: 'doc',
          docId: 'intro',
          position: 'left',
          label: 'Tutorial',
        },
        {to: '/blog', label: 'Blog', position: 'left'},
        {
          href: 'https://pub.dev/packages/ap_common',
          label: 'Pub',
          position: 'right',
        },
        {
          href: 'https://github.com/abc873693/ap_common',
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Docs',
          items: [
            {
              label: 'Tutorial',
              to: '/docs/intro',
            },
          ],
        },
        {
          title: 'Community',
          items: [
            {
              label: '高雄科技大學資訊研習社',
              href: 'https://github.com/NKUST-ITC',
            },
            {
              label: '中山大學程式研習社',
              href: 'https://github.com/nsysu-code-club',
            },
          ],
        },
        {
          title: 'More',
          items: [
            {
              label: 'Blog',
              to: '/blog',
            },
            {
              label: 'GitHub',
              href: 'https://github.com/abc873693/ap_common',
            },
          ],
        },
      ],
      copyright: `Copyright © ${new Date().getFullYear()} AP-Common, Built with Docusaurus.`,
    },
  },
  presets: [
    [
      '@docusaurus/preset-classic',
      {
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          // Please change this to your repo.
          editUrl:
            'https://github.com/facebook/docusaurus/edit/master/website/',
        },
        blog: {
          showReadingTime: true,
          // Please change this to your repo.
          editUrl:
            'https://github.com/facebook/docusaurus/edit/master/website/blog/',
        },
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      },
    ],
  ],
};
