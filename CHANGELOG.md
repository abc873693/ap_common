# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 2024-12-18

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common_flutter_platform` - `v0.0.4`](#ap_common_flutter_platform---v004)
 - [`ap_common` - `v0.26.0-dev.4`](#ap_common---v0260-dev4)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `ap_common` - `v0.26.0-dev.4`

---

#### `ap_common_flutter_platform` - `v0.0.4`

 - **FEAT**: upgrade package for package `web` 1.0.0. ([c0ac3e33](https://github.com/abc873693/ap_common/commit/c0ac3e331b64a436e909a8ec7ab2983974ae37a4))


## 2024-12-18

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common_plugin` - `v0.5.0-dev.3`](#ap_common_plugin---v050-dev3)

---

#### `ap_common_plugin` - `v0.5.0-dev.3`

 - **FEAT**(ap_common_plugin): update iOS setting for flutter 3.27 create. ([e65572db](https://github.com/abc873693/ap_common/commit/e65572dbd5f92b22612b4e7b4295aeca6b3bf42e))
 - **FEAT**(ap_common_plugin): upgrade gradle 8 setting for android 15. ([862d08af](https://github.com/abc873693/ap_common/commit/862d08af7006fa55ad42b23f9395cf95aed07916))


## 2024-10-13

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common` - `v0.26.0-dev.3`](#ap_common---v0260-dev3)
 - [`ap_common_announcement_ui` - `v0.0.3`](#ap_common_announcement_ui---v003)
 - [`ap_common_core` - `v0.0.5`](#ap_common_core---v005)
 - [`ap_common_firebase` - `v0.17.0-dev.4`](#ap_common_firebase---v0170-dev4)
 - [`ap_common_flutter_core` - `v0.0.3`](#ap_common_flutter_core---v003)
 - [`ap_common_flutter_platform` - `v0.0.3`](#ap_common_flutter_platform---v003)
 - [`ap_common_flutter_ui` - `v0.0.3`](#ap_common_flutter_ui---v003)
 - [`ap_common_plugin` - `v0.5.0-dev.2`](#ap_common_plugin---v050-dev2)

---

#### `ap_common` - `v0.26.0-dev.3`

 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([55b2fa00](https://github.com/abc873693/ap_common/commit/55b2fa00ea5fa4dafb15fc19e19b33dd9d72ef92))
 - **FEAT**: `AppStoreUtil` and `PlatformUtil` for `ap_common_flutter_core`. ([f9abb16d](https://github.com/abc873693/ap_common/commit/f9abb16d2e525ff8d5d4a68cd7a098e8025cd772))
 - **FEAT**: migrate `util` `l10n`  to new `ap_common_flutter_core`. ([be152bac](https://github.com/abc873693/ap_common/commit/be152bac1b94f8e80baba9c098a938c44246b810))
 - **FEAT**: centralized package lint rule. ([c2b8ad80](https://github.com/abc873693/ap_common/commit/c2b8ad8000bb19d0d5fccdaf63f0411329e6dcfa))
 - **FEAT**: migrate `NotificationUtil` and `Preference` to injection version. ([4326c12e](https://github.com/abc873693/ap_common/commit/4326c12e28732d86a1b5a0fff2fdd6d3a3c6e5e6))
 - **FEAT**: `ap_common` import `ap_common_core`. ([d463f7c7](https://github.com/abc873693/ap_common/commit/d463f7c7b5cd78c171b90eea0210f81649fc5626))
 - **FEAT**: migrate `model`  `util` `config` to new `ap_common_core`. ([3887bc05](https://github.com/abc873693/ap_common/commit/3887bc05ebf8612f2b2a1cc607ec3c3fdf3135e1))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([8cb047f1](https://github.com/abc873693/ap_common/commit/8cb047f167d6f10eaab063449a88646092faff10))
 - **FEAT**: `AppStoreUtil` and `PlatformUtil` for `ap_common_flutter_core`. ([d87dc711](https://github.com/abc873693/ap_common/commit/d87dc7117a040b31b42abd2d1122a891fd04988e))
 - **FEAT**: migrate `util` `l10n`  to new `ap_common_flutter_core`. ([e91e9b4c](https://github.com/abc873693/ap_common/commit/e91e9b4cdf3cb7d4e2dde1dd8ec5f66556d38461))
 - **FEAT**: centralized package lint rule. ([08db9e1f](https://github.com/abc873693/ap_common/commit/08db9e1f00118f11ef389b194585626d7c51c3ab))
 - **FEAT**: migrate `NotificationUtil` and `Preference` to injection version. ([ac50e177](https://github.com/abc873693/ap_common/commit/ac50e177cb276937b2411397959a845f98fa297a))
 - **FEAT**: `ap_common` import `ap_common_core`. ([a6aa801f](https://github.com/abc873693/ap_common/commit/a6aa801f2165281be61afbe33f4072827e5979bc))
 - **FEAT**: migrate `model`  `util` `config` to new `ap_common_core`. ([90f16bc9](https://github.com/abc873693/ap_common/commit/90f16bc9e38eb10f2d8f3b633f4c46a0a9e2ff95))

#### `ap_common_announcement_ui` - `v0.0.3`

 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: packages version constraint. ([8231a423](https://github.com/abc873693/ap_common/commit/8231a423b237d6f38b3531ec4fc2b06e713a6c51))
 - **FIX**: pub publish requirement. ([839ad892](https://github.com/abc873693/ap_common/commit/839ad892cb67fb04d8c1f877129faa2847c76f77))
 - **FIX**: packages version constraint. ([783781bd](https://github.com/abc873693/ap_common/commit/783781bdb314a93b89415f8de9fb6acdcd38a222))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))

#### `ap_common_core` - `v0.0.5`

 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: `ap_common_core` separate static error. ([177a00fd](https://github.com/abc873693/ap_common/commit/177a00fd613c7d869643f8d2c7ab02bc102fc064))
 - **FIX**: pub publish requirement. ([839ad892](https://github.com/abc873693/ap_common/commit/839ad892cb67fb04d8c1f877129faa2847c76f77))
 - **FIX**: `ap_common_core` separate static error. ([629ba29d](https://github.com/abc873693/ap_common/commit/629ba29d7d0aa59270eec1da45e49daebe3bf8b5))
 - **FEAT**: `AnalyticsUtil` and `CrashlyticsUtil` migrate to injection version. ([0e8a9aab](https://github.com/abc873693/ap_common/commit/0e8a9aab76b2a6994dbcfdf4814e6f7104e4b312))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([55b2fa00](https://github.com/abc873693/ap_common/commit/55b2fa00ea5fa4dafb15fc19e19b33dd9d72ef92))
 - **FEAT**: migrate `util` `l10n`  to new `ap_common_flutter_core`. ([be152bac](https://github.com/abc873693/ap_common/commit/be152bac1b94f8e80baba9c098a938c44246b810))
 - **FEAT**: centralized package lint rule. ([c2b8ad80](https://github.com/abc873693/ap_common/commit/c2b8ad8000bb19d0d5fccdaf63f0411329e6dcfa))
 - **FEAT**: release `ap_common_core` v0.0.2. ([7eef7658](https://github.com/abc873693/ap_common/commit/7eef76580b57b66dfd78f5692cdc2a8748f575a3))
 - **FEAT**: migrate `NotificationUtil` and `Preference` to injection version. ([4326c12e](https://github.com/abc873693/ap_common/commit/4326c12e28732d86a1b5a0fff2fdd6d3a3c6e5e6))
 - **FEAT**: `ap_common` import `ap_common_core`. ([d463f7c7](https://github.com/abc873693/ap_common/commit/d463f7c7b5cd78c171b90eea0210f81649fc5626))
 - **FEAT**: migrate `model`  `util` `config` to new `ap_common_core`. ([3887bc05](https://github.com/abc873693/ap_common/commit/3887bc05ebf8612f2b2a1cc607ec3c3fdf3135e1))
 - **FEAT**: `AnalyticsUtil` and `CrashlyticsUtil` migrate to injection version. ([f633fae8](https://github.com/abc873693/ap_common/commit/f633fae8d102d32624e23acad2c00c06c27b4dde))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([8cb047f1](https://github.com/abc873693/ap_common/commit/8cb047f167d6f10eaab063449a88646092faff10))
 - **FEAT**: migrate `util` `l10n`  to new `ap_common_flutter_core`. ([e91e9b4c](https://github.com/abc873693/ap_common/commit/e91e9b4cdf3cb7d4e2dde1dd8ec5f66556d38461))
 - **FEAT**: centralized package lint rule. ([08db9e1f](https://github.com/abc873693/ap_common/commit/08db9e1f00118f11ef389b194585626d7c51c3ab))
 - **FEAT**: release `ap_common_core` v0.0.2. ([630bcec0](https://github.com/abc873693/ap_common/commit/630bcec0b9158ddd91c5fab9de1f630447547490))
 - **FEAT**: migrate `NotificationUtil` and `Preference` to injection version. ([ac50e177](https://github.com/abc873693/ap_common/commit/ac50e177cb276937b2411397959a845f98fa297a))
 - **FEAT**: `ap_common` import `ap_common_core`. ([a6aa801f](https://github.com/abc873693/ap_common/commit/a6aa801f2165281be61afbe33f4072827e5979bc))
 - **FEAT**: migrate `model`  `util` `config` to new `ap_common_core`. ([90f16bc9](https://github.com/abc873693/ap_common/commit/90f16bc9e38eb10f2d8f3b633f4c46a0a9e2ff95))

#### `ap_common_firebase` - `v0.17.0-dev.4`

 - **FIX**: remove useless implement instance. ([a7ffaeb0](https://github.com/abc873693/ap_common/commit/a7ffaeb07914c1d1fbe32919cce95c5708843230))
 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: packages version constraint. ([8231a423](https://github.com/abc873693/ap_common/commit/8231a423b237d6f38b3531ec4fc2b06e713a6c51))
 - **FIX**: `ap_common_firebase` dependency usage. ([0c0b9e51](https://github.com/abc873693/ap_common/commit/0c0b9e510345c5482f69b4ea5fdcebdf217c565c))
 - **FIX**: `ap_common_firebase` separate static error. ([65b8a273](https://github.com/abc873693/ap_common/commit/65b8a2738092e0e261cd4088c778d54784e44b05))
 - **FIX**: remove useless implement instance. ([3ec164dd](https://github.com/abc873693/ap_common/commit/3ec164dd62590e684855128da1052cae34705bbb))
 - **FIX**: pub publish requirement. ([839ad892](https://github.com/abc873693/ap_common/commit/839ad892cb67fb04d8c1f877129faa2847c76f77))
 - **FIX**: packages version constraint. ([783781bd](https://github.com/abc873693/ap_common/commit/783781bdb314a93b89415f8de9fb6acdcd38a222))
 - **FIX**: `ap_common_firebase` dependency usage. ([d5098b42](https://github.com/abc873693/ap_common/commit/d5098b426c00de39c0736a8ca535a76be0722331))
 - **FIX**: `ap_common_firebase` separate static error. ([1c8da8ea](https://github.com/abc873693/ap_common/commit/1c8da8ea57c7e3e48d3e53a824e76968d56a97b5))
 - **FEAT**: `AnalyticsUtil` and `CrashlyticsUtil` migrate to injection version. ([0e8a9aab](https://github.com/abc873693/ap_common/commit/0e8a9aab76b2a6994dbcfdf4814e6f7104e4b312))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([55b2fa00](https://github.com/abc873693/ap_common/commit/55b2fa00ea5fa4dafb15fc19e19b33dd9d72ef92))
 - **FEAT**: improve `ap_common_firebase` package import usage. ([7d021992](https://github.com/abc873693/ap_common/commit/7d0219927e3b4a7c2a924cdce86dd471f7564e19))
 - **FEAT**: centralized package lint rule. ([c2b8ad80](https://github.com/abc873693/ap_common/commit/c2b8ad8000bb19d0d5fccdaf63f0411329e6dcfa))
 - **FEAT**: `AnalyticsUtil` and `CrashlyticsUtil` migrate to injection version. ([f633fae8](https://github.com/abc873693/ap_common/commit/f633fae8d102d32624e23acad2c00c06c27b4dde))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([8cb047f1](https://github.com/abc873693/ap_common/commit/8cb047f167d6f10eaab063449a88646092faff10))
 - **FEAT**: improve `ap_common_firebase` package import usage. ([aa6462c4](https://github.com/abc873693/ap_common/commit/aa6462c407b074b6fa95969765e28c85dc187de5))
 - **FEAT**: centralized package lint rule. ([08db9e1f](https://github.com/abc873693/ap_common/commit/08db9e1f00118f11ef389b194585626d7c51c3ab))

#### `ap_common_flutter_core` - `v0.0.3`

 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: packages version constraint. ([8231a423](https://github.com/abc873693/ap_common/commit/8231a423b237d6f38b3531ec4fc2b06e713a6c51))
 - **FIX**: pub publish requirement. ([839ad892](https://github.com/abc873693/ap_common/commit/839ad892cb67fb04d8c1f877129faa2847c76f77))
 - **FIX**: packages version constraint. ([783781bd](https://github.com/abc873693/ap_common/commit/783781bdb314a93b89415f8de9fb6acdcd38a222))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([55b2fa00](https://github.com/abc873693/ap_common/commit/55b2fa00ea5fa4dafb15fc19e19b33dd9d72ef92))
 - **FEAT**: `AppStoreUtil` and `PlatformUtil` for `ap_common_flutter_core`. ([f9abb16d](https://github.com/abc873693/ap_common/commit/f9abb16d2e525ff8d5d4a68cd7a098e8025cd772))
 - **FEAT**: migrate `util` `l10n`  to new `ap_common_flutter_core`. ([be152bac](https://github.com/abc873693/ap_common/commit/be152bac1b94f8e80baba9c098a938c44246b810))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([8cb047f1](https://github.com/abc873693/ap_common/commit/8cb047f167d6f10eaab063449a88646092faff10))
 - **FEAT**: `AppStoreUtil` and `PlatformUtil` for `ap_common_flutter_core`. ([d87dc711](https://github.com/abc873693/ap_common/commit/d87dc7117a040b31b42abd2d1122a891fd04988e))
 - **FEAT**: migrate `util` `l10n`  to new `ap_common_flutter_core`. ([e91e9b4c](https://github.com/abc873693/ap_common/commit/e91e9b4cdf3cb7d4e2dde1dd8ec5f66556d38461))

#### `ap_common_flutter_platform` - `v0.0.3`

 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: packages version constraint. ([8231a423](https://github.com/abc873693/ap_common/commit/8231a423b237d6f38b3531ec4fc2b06e713a6c51))
 - **FIX**: pub publish requirement. ([839ad892](https://github.com/abc873693/ap_common/commit/839ad892cb67fb04d8c1f877129faa2847c76f77))
 - **FIX**: packages version constraint. ([783781bd](https://github.com/abc873693/ap_common/commit/783781bdb314a93b89415f8de9fb6acdcd38a222))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([55b2fa00](https://github.com/abc873693/ap_common/commit/55b2fa00ea5fa4dafb15fc19e19b33dd9d72ef92))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([8cb047f1](https://github.com/abc873693/ap_common/commit/8cb047f167d6f10eaab063449a88646092faff10))

#### `ap_common_flutter_ui` - `v0.0.3`

 - **FIX**: `ApAssets` path error. ([558e5445](https://github.com/abc873693/ap_common/commit/558e54451ed7ae1d1d0a9de2e74a8c2172845b9b))
 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: packages version constraint. ([8231a423](https://github.com/abc873693/ap_common/commit/8231a423b237d6f38b3531ec4fc2b06e713a6c51))
 - **FIX**: `ApAssets` path error. ([c70fdd2d](https://github.com/abc873693/ap_common/commit/c70fdd2dd9b470215f3d28d79197fc1b427397ef))
 - **FIX**: pub publish requirement. ([839ad892](https://github.com/abc873693/ap_common/commit/839ad892cb67fb04d8c1f877129faa2847c76f77))
 - **FIX**: packages version constraint. ([783781bd](https://github.com/abc873693/ap_common/commit/783781bdb314a93b89415f8de9fb6acdcd38a222))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))

#### `ap_common_plugin` - `v0.5.0-dev.2`

 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: packages version constraint. ([8231a423](https://github.com/abc873693/ap_common/commit/8231a423b237d6f38b3531ec4fc2b06e713a6c51))
 - **FIX**: pub publish requirement. ([839ad892](https://github.com/abc873693/ap_common/commit/839ad892cb67fb04d8c1f877129faa2847c76f77))
 - **FIX**: packages version constraint. ([783781bd](https://github.com/abc873693/ap_common/commit/783781bdb314a93b89415f8de9fb6acdcd38a222))
 - **FEAT**: centralized package lint rule. ([c2b8ad80](https://github.com/abc873693/ap_common/commit/c2b8ad8000bb19d0d5fccdaf63f0411329e6dcfa))
 - **FEAT**: centralized package lint rule. ([08db9e1f](https://github.com/abc873693/ap_common/commit/08db9e1f00118f11ef389b194585626d7c51c3ab))


## 2024-10-12

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common_firebase` - `v0.17.0-dev.3`](#ap_common_firebase---v0170-dev3)

---

#### `ap_common_firebase` - `v0.17.0-dev.3`

 - **FIX**: remove useless implement instance. ([3ec164dd](https://github.com/abc873693/ap_common/commit/3ec164dd62590e684855128da1052cae34705bbb))


## 2024-10-12

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common_announcement_ui` - `v0.0.2+1`](#ap_common_announcement_ui---v0021)
 - [`ap_common_core` - `v0.0.4`](#ap_common_core---v004)
 - [`ap_common_firebase` - `v0.17.0-dev.2`](#ap_common_firebase---v0170-dev2)
 - [`ap_common_flutter_core` - `v0.0.2+1`](#ap_common_flutter_core---v0021)
 - [`ap_common_flutter_platform` - `v0.0.2+1`](#ap_common_flutter_platform---v0021)
 - [`ap_common_flutter_ui` - `v0.0.2+1`](#ap_common_flutter_ui---v0021)
 - [`ap_common_plugin` - `v0.5.0-dev.1`](#ap_common_plugin---v050-dev1)
 - [`ap_common` - `v0.26.0-dev.2`](#ap_common---v0260-dev2)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `ap_common` - `v0.26.0-dev.2`

---

#### `ap_common_announcement_ui` - `v0.0.2+1`

 - **FIX**: pub publish requirement. ([839ad892](https://github.com/abc873693/ap_common/commit/839ad892cb67fb04d8c1f877129faa2847c76f77))
 - **FIX**: packages version constraint. ([783781bd](https://github.com/abc873693/ap_common/commit/783781bdb314a93b89415f8de9fb6acdcd38a222))

#### `ap_common_core` - `v0.0.4`

 - **FIX**: pub publish requirement. ([839ad892](https://github.com/abc873693/ap_common/commit/839ad892cb67fb04d8c1f877129faa2847c76f77))
 - **FEAT**: `AnalyticsUtil` and `CrashlyticsUtil` migrate to injection version. ([f633fae8](https://github.com/abc873693/ap_common/commit/f633fae8d102d32624e23acad2c00c06c27b4dde))

#### `ap_common_firebase` - `v0.17.0-dev.2`

 - **FIX**: pub publish requirement. ([839ad892](https://github.com/abc873693/ap_common/commit/839ad892cb67fb04d8c1f877129faa2847c76f77))
 - **FIX**: packages version constraint. ([783781bd](https://github.com/abc873693/ap_common/commit/783781bdb314a93b89415f8de9fb6acdcd38a222))
 - **FEAT**: `AnalyticsUtil` and `CrashlyticsUtil` migrate to injection version. ([f633fae8](https://github.com/abc873693/ap_common/commit/f633fae8d102d32624e23acad2c00c06c27b4dde))

#### `ap_common_flutter_core` - `v0.0.2+1`

 - **FIX**: pub publish requirement. ([839ad892](https://github.com/abc873693/ap_common/commit/839ad892cb67fb04d8c1f877129faa2847c76f77))
 - **FIX**: packages version constraint. ([783781bd](https://github.com/abc873693/ap_common/commit/783781bdb314a93b89415f8de9fb6acdcd38a222))

#### `ap_common_flutter_platform` - `v0.0.2+1`

 - **FIX**: pub publish requirement. ([839ad892](https://github.com/abc873693/ap_common/commit/839ad892cb67fb04d8c1f877129faa2847c76f77))
 - **FIX**: packages version constraint. ([783781bd](https://github.com/abc873693/ap_common/commit/783781bdb314a93b89415f8de9fb6acdcd38a222))

#### `ap_common_flutter_ui` - `v0.0.2+1`

 - **FIX**: `ApAssets` path error. ([c70fdd2d](https://github.com/abc873693/ap_common/commit/c70fdd2dd9b470215f3d28d79197fc1b427397ef))
 - **FIX**: pub publish requirement. ([839ad892](https://github.com/abc873693/ap_common/commit/839ad892cb67fb04d8c1f877129faa2847c76f77))
 - **FIX**: packages version constraint. ([783781bd](https://github.com/abc873693/ap_common/commit/783781bdb314a93b89415f8de9fb6acdcd38a222))

#### `ap_common_plugin` - `v0.5.0-dev.1`

 - **FIX**: pub publish requirement. ([839ad892](https://github.com/abc873693/ap_common/commit/839ad892cb67fb04d8c1f877129faa2847c76f77))
 - **FIX**: packages version constraint. ([783781bd](https://github.com/abc873693/ap_common/commit/783781bdb314a93b89415f8de9fb6acdcd38a222))


## 2024-10-11

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common` - `v0.26.0-dev.1`](#ap_common---v0260-dev1)
 - [`ap_common_announcement_ui` - `v0.0.2`](#ap_common_announcement_ui---v002)
 - [`ap_common_core` - `v0.0.3`](#ap_common_core---v003)
 - [`ap_common_flutter_core` - `v0.0.2`](#ap_common_flutter_core---v002)
 - [`ap_common_flutter_platform` - `v0.0.2`](#ap_common_flutter_platform---v002)
 - [`ap_common_flutter_ui` - `v0.0.2`](#ap_common_flutter_ui---v002)
 - [`ap_common_firebase` - `v0.17.0-dev.1`](#ap_common_firebase---v0170-dev1)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `ap_common_firebase` - `v0.17.0-dev.1`

---

#### `ap_common` - `v0.26.0-dev.1`

 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([8cb047f1](https://github.com/abc873693/ap_common/commit/8cb047f167d6f10eaab063449a88646092faff10))
 - **FEAT**: `AppStoreUtil` and `PlatformUtil` for `ap_common_flutter_core`. ([d87dc711](https://github.com/abc873693/ap_common/commit/d87dc7117a040b31b42abd2d1122a891fd04988e))
 - **FEAT**: migrate `util` `l10n`  to new `ap_common_flutter_core`. ([e91e9b4c](https://github.com/abc873693/ap_common/commit/e91e9b4cdf3cb7d4e2dde1dd8ec5f66556d38461))
 - **FEAT**: centralized package lint rule. ([08db9e1f](https://github.com/abc873693/ap_common/commit/08db9e1f00118f11ef389b194585626d7c51c3ab))
 - **FEAT**: migrate `NotificationUtil` and `Preference` to injection version. ([ac50e177](https://github.com/abc873693/ap_common/commit/ac50e177cb276937b2411397959a845f98fa297a))
 - **FEAT**: `ap_common` import `ap_common_core`. ([a6aa801f](https://github.com/abc873693/ap_common/commit/a6aa801f2165281be61afbe33f4072827e5979bc))
 - **FEAT**: migrate `model`  `util` `config` to new `ap_common_core`. ([90f16bc9](https://github.com/abc873693/ap_common/commit/90f16bc9e38eb10f2d8f3b633f4c46a0a9e2ff95))
 - **FEAT**: update example path. ([4d7390c9](https://github.com/abc873693/ap_common/commit/4d7390c9212631e1233c37c901a4454610783926))
 - **FEAT**: move main package to directory `packages` for melos prepare. ([8af51340](https://github.com/abc873693/ap_common/commit/8af51340576e8236b261a21188cc8feaa0776785))

#### `ap_common_announcement_ui` - `v0.0.2`

 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))

#### `ap_common_core` - `v0.0.3`

 - **FIX**: `ap_common_core` separate static error. ([629ba29d](https://github.com/abc873693/ap_common/commit/629ba29d7d0aa59270eec1da45e49daebe3bf8b5))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([8cb047f1](https://github.com/abc873693/ap_common/commit/8cb047f167d6f10eaab063449a88646092faff10))
 - **FEAT**: migrate `util` `l10n`  to new `ap_common_flutter_core`. ([e91e9b4c](https://github.com/abc873693/ap_common/commit/e91e9b4cdf3cb7d4e2dde1dd8ec5f66556d38461))
 - **FEAT**: centralized package lint rule. ([08db9e1f](https://github.com/abc873693/ap_common/commit/08db9e1f00118f11ef389b194585626d7c51c3ab))
 - **FEAT**: release `ap_common_core` v0.0.2. ([630bcec0](https://github.com/abc873693/ap_common/commit/630bcec0b9158ddd91c5fab9de1f630447547490))
 - **FEAT**: migrate `NotificationUtil` and `Preference` to injection version. ([ac50e177](https://github.com/abc873693/ap_common/commit/ac50e177cb276937b2411397959a845f98fa297a))
 - **FEAT**: `ap_common` import `ap_common_core`. ([a6aa801f](https://github.com/abc873693/ap_common/commit/a6aa801f2165281be61afbe33f4072827e5979bc))
 - **FEAT**: migrate `model`  `util` `config` to new `ap_common_core`. ([90f16bc9](https://github.com/abc873693/ap_common/commit/90f16bc9e38eb10f2d8f3b633f4c46a0a9e2ff95))

#### `ap_common_flutter_core` - `v0.0.2`

 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([8cb047f1](https://github.com/abc873693/ap_common/commit/8cb047f167d6f10eaab063449a88646092faff10))
 - **FEAT**: `AppStoreUtil` and `PlatformUtil` for `ap_common_flutter_core`. ([d87dc711](https://github.com/abc873693/ap_common/commit/d87dc7117a040b31b42abd2d1122a891fd04988e))
 - **FEAT**: migrate `util` `l10n`  to new `ap_common_flutter_core`. ([e91e9b4c](https://github.com/abc873693/ap_common/commit/e91e9b4cdf3cb7d4e2dde1dd8ec5f66556d38461))

#### `ap_common_flutter_platform` - `v0.0.2`

 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([8cb047f1](https://github.com/abc873693/ap_common/commit/8cb047f167d6f10eaab063449a88646092faff10))

#### `ap_common_flutter_ui` - `v0.0.2`

 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))


## 2024-10-11

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common_plugin` - `v0.5.0-dev.0`](#ap_common_plugin---v050-dev0)

---

#### `ap_common_plugin` - `v0.5.0-dev.0`

 - **FEAT**: centralized package lint rule. ([08db9e1f](https://github.com/abc873693/ap_common/commit/08db9e1f00118f11ef389b194585626d7c51c3ab))
 - **FEAT**: update example path. ([4d7390c9](https://github.com/abc873693/ap_common/commit/4d7390c9212631e1233c37c901a4454610783926))
 - **FEAT**: CI setting for mono-repo. ([d22f6d15](https://github.com/abc873693/ap_common/commit/d22f6d15f64879dbf9711574aba4bba6e227f128))
 - **FEAT**: melos generation setup. ([90497edd](https://github.com/abc873693/ap_common/commit/90497edd12d449e66991d654a03175edebf1e816))
 - **FEAT**: melos basic setting. ([fa8e1946](https://github.com/abc873693/ap_common/commit/fa8e1946fd478c1a0cf1635eaeb0fb60cc264750))


## 2024-10-11

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common_firebase` - `v0.17.0-dev.0`](#ap_common_firebase---v0170-dev0)

---

#### `ap_common_firebase` - `v0.17.0-dev.0`

 - **FIX**: `ap_common_firebase` dependency usage. ([d5098b42](https://github.com/abc873693/ap_common/commit/d5098b426c00de39c0736a8ca535a76be0722331))
 - **FIX**: `ap_common_firebase` separate static error. ([1c8da8ea](https://github.com/abc873693/ap_common/commit/1c8da8ea57c7e3e48d3e53a824e76968d56a97b5))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([8cb047f1](https://github.com/abc873693/ap_common/commit/8cb047f167d6f10eaab063449a88646092faff10))
 - **FEAT**: improve `ap_common_firebase` package import usage. ([aa6462c4](https://github.com/abc873693/ap_common/commit/aa6462c407b074b6fa95969765e28c85dc187de5))
 - **FEAT**: centralized package lint rule. ([08db9e1f](https://github.com/abc873693/ap_common/commit/08db9e1f00118f11ef389b194585626d7c51c3ab))
 - **FEAT**: update example path. ([4d7390c9](https://github.com/abc873693/ap_common/commit/4d7390c9212631e1233c37c901a4454610783926))
 - **FEAT**: melos generation setup. ([90497edd](https://github.com/abc873693/ap_common/commit/90497edd12d449e66991d654a03175edebf1e816))
 - **FEAT**: melos basic setting. ([f2d4fafd](https://github.com/abc873693/ap_common/commit/f2d4fafd48c812901f5394fb83f6f5e5ff67401c))


## 2024-10-11

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common_firebase` - `v0.17.0-dev.0`](#ap_common_firebase---v0170-dev0)

---

#### `ap_common_firebase` - `v0.17.0-dev.0`

 - test

 - **FIX**: `ap_common_firebase` dependency usage. ([d5098b42](https://github.com/abc873693/ap_common/commit/d5098b426c00de39c0736a8ca535a76be0722331))
 - **FIX**: `ap_common_firebase` separate static error. ([1c8da8ea](https://github.com/abc873693/ap_common/commit/1c8da8ea57c7e3e48d3e53a824e76968d56a97b5))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([8cb047f1](https://github.com/abc873693/ap_common/commit/8cb047f167d6f10eaab063449a88646092faff10))
 - **FEAT**: improve `ap_common_firebase` package import usage. ([aa6462c4](https://github.com/abc873693/ap_common/commit/aa6462c407b074b6fa95969765e28c85dc187de5))
 - **FEAT**: centralized package lint rule. ([08db9e1f](https://github.com/abc873693/ap_common/commit/08db9e1f00118f11ef389b194585626d7c51c3ab))
 - **FEAT**: update example path. ([4d7390c9](https://github.com/abc873693/ap_common/commit/4d7390c9212631e1233c37c901a4454610783926))
 - **FEAT**: melos generation setup. ([90497edd](https://github.com/abc873693/ap_common/commit/90497edd12d449e66991d654a03175edebf1e816))
 - **FEAT**: melos basic setting. ([f2d4fafd](https://github.com/abc873693/ap_common/commit/f2d4fafd48c812901f5394fb83f6f5e5ff67401c))

