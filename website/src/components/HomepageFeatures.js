import React from 'react';
import clsx from 'clsx';
import styles from './HomepageFeatures.module.css';

const FeatureList = [
  {
    title: 'Better UI/UX',
    Svg: require('../../static/img/undraw_docusaurus_mountain.svg').default,
    description: (
      <>
        以 <a href="https://material.io/design">Material Design</a>
        設計學生常使用到的課表、成績等使用者介面，
        提供更好的使用者體驗
      </>
    ),
  },
  {
    title: 'More Powerful',
    Svg: require('../../static/img/undraw_docusaurus_tree.svg').default,
    description: (
      <>
        使用 Google 開源的框架 <a href="https://flutter.dev/design">Flutter</a> 開發，
        讓你的 App 可以部署到 <code>Android</code>、<code>iOS</code>、<code>Web</code>、
        <code>macOS</code>、<code>Linux</code> 與 <code>Windows</code> 等多個平台
      </>
    ),
  },
  {
    title: 'Open Source',
    Svg: require('../../static/img/undraw_docusaurus_react.svg').default,
    description: (
      <>
        永遠開放原始碼，
        可於 <code>GitHub</code> 找到我們的程式碼，
        並於 <a href="https://pub.dev/ap_common">Pub</a> 提供套件
      </>
    ),
  },
];

function Feature({Svg, title, description}) {
  return (
    <div className={clsx('col col--4')}>
      <div className="text--center">
        <Svg className={styles.featureSvg} alt={title} />
      </div>
      <div className="text--center padding-horiz--md">
        <h3>{title}</h3>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures() {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
