# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 2026-04-03

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common` - `v1.0.1-dev.3`](#ap_common---v101-dev3)
 - [`ap_common_announcement_ui` - `v1.0.1-dev.4`](#ap_common_announcement_ui---v101-dev4)
 - [`ap_common_core` - `v1.0.1-dev.1`](#ap_common_core---v101-dev1)
 - [`ap_common_firebase` - `v1.0.1-dev.4`](#ap_common_firebase---v101-dev4)
 - [`ap_common_flutter_core` - `v1.1.0-dev.4`](#ap_common_flutter_core---v110-dev4)
 - [`ap_common_flutter_platform` - `v1.0.1-dev.4`](#ap_common_flutter_platform---v101-dev4)
 - [`ap_common_flutter_ui` - `v1.1.0-dev.4`](#ap_common_flutter_ui---v110-dev4)
 - [`ap_common_plugin` - `v1.0.1-dev.3`](#ap_common_plugin---v101-dev3)

---

#### `ap_common` - `v1.0.1-dev.3`

 - **REFACTOR**(ui): fix lint errors and improve code quality. ([36a092bd](https://github.com/abc873693/ap_common/commit/36a092bd42002835b5ea2252c15d21f78d39691d))
 - **FIX**(deps): downgrade ap_common version and fix flutter_ui constraint. ([c3167a59](https://github.com/abc873693/ap_common/commit/c3167a590546fcac8cc858dd4c97ac5b87d4be51))
 - **DOCS**(swagger): sync announcement_api.json with current implementation. ([ce398d86](https://github.com/abc873693/ap_common/commit/ce398d865056f734652cf80454add2a2030aa101))

#### `ap_common_announcement_ui` - `v1.0.1-dev.4`

 - **REFACTOR**(announcement): add showErrorToast extension and simplify UI error handling. ([dc46221d](https://github.com/abc873693/ap_common/commit/dc46221d222f1a68a458d6a226d82ccf7bf7049a))
 - **REFACTOR**(announcement): migrate UI pages to async/await with ApiResult. ([31902f52](https://github.com/abc873693/ap_common/commit/31902f525e92830fd6c88fde3555e4ba58ba6d05))
 - **REFACTOR**(announcement): rewrite API helpers with ApiResult, remove GeneralCallback. ([715803a4](https://github.com/abc873693/ap_common/commit/715803a4fd1c45cda7b66c0857150cdfb79062f4))
 - **REFACTOR**(l10n): use context-based translation access for reactive locale switching. ([e9429aa1](https://github.com/abc873693/ap_common/commit/e9429aa1bbfc2e97b72e0010d8bebf63777b050d))
 - **REFACTOR**(l10n): restore original i18n variable naming conventions. ([c21ed521](https://github.com/abc873693/ap_common/commit/c21ed521369b6a3f6030da7ac9a9bae6b97d13dd))
 - **REFACTOR**(l10n): update UI packages to use slang translation API. ([697e1e15](https://github.com/abc873693/ap_common/commit/697e1e15b28ab194f71e322da1acf48d14fb2cd2))
 - **FIX**: reject and add to ban error. ([80734bed](https://github.com/abc873693/ap_common/commit/80734bed83acf7e9a7b334c0a5754269cd8030e5))
 - **FIX**(announcement): handle nested API errors in _announcementSubmit. ([819636e4](https://github.com/abc873693/ap_common/commit/819636e4f5aeddc2ea427bb91ebdc1d6aac0ca5e))
 - **FIX**: resolve analyze-ci lint issues in changed files. ([ea86b935](https://github.com/abc873693/ap_common/commit/ea86b9350c97dac8e51fad98273c4d9f2925e3b7))
 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: packages version constraint. ([8231a423](https://github.com/abc873693/ap_common/commit/8231a423b237d6f38b3531ec4fc2b06e713a6c51))
 - **FEAT**(announcement): display applicant email on edit application page. ([f898b3e7](https://github.com/abc873693/ap_common/commit/f898b3e7544a72bcb250fbb3e09ead662482fbf0))
 - **FEAT**: improve model generate by `freezed`. ([43bef51c](https://github.com/abc873693/ap_common/commit/43bef51c42f8cf8b984074d42c16c403ee83c02c))
 - **FEAT**: align image upload naming. ([ab2f2492](https://github.com/abc873693/ap_common/commit/ab2f2492f05117a2474357cbd7373498b40df878))
 - **FEAT**: revert imgur implement. ([30bbf5ea](https://github.com/abc873693/ap_common/commit/30bbf5eadc1b05d08f5c269169e9bfe715c5bbb0))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))

#### `ap_common_core` - `v1.0.1-dev.1`

 - **REFACTOR**(l10n): address code review feedback. ([7c7b84e0](https://github.com/abc873693/ap_common/commit/7c7b84e08be6352a3e50d427ce792834c0435a2c))
 - **REFACTOR**(l10n): clean up intl remnants after slang migration. ([ea893e6d](https://github.com/abc873693/ap_common/commit/ea893e6d5b0e0587231cab2741e309da909d5a7b))
 - **REFACTOR**(core): introduce ApiResult sealed class for typed API responses. ([8538398e](https://github.com/abc873693/ap_common/commit/8538398e9514ea653847833b5ce571ef44b89c2f))
 - **FIX**: resolve analyze errors and lint issues in simplified UI integration. ([d0f2e45e](https://github.com/abc873693/ap_common/commit/d0f2e45eef25441b5786f3e65f4190b4e798b342))
 - **FIX**: resolve all pre-existing lint issues across packages. ([13d260b3](https://github.com/abc873693/ap_common/commit/13d260b36a8fc21b79cd1ab94d855d0138e5d9b3))
 - **FIX**: resolve analyze-ci lint issues in changed files. ([ea86b935](https://github.com/abc873693/ap_common/commit/ea86b9350c97dac8e51fad98273c4d9f2925e3b7))
 - **FIX**: resolve all pre-existing lint issues across packages. ([84db9998](https://github.com/abc873693/ap_common/commit/84db99986ccfac62b720cbf69f03bc021c154bc5))
 - **FIX**(firebase): upgrade firebase deps and adapt to new API. ([7540d9db](https://github.com/abc873693/ap_common/commit/7540d9db6474bef1e6952a72366686389087f2ad))
 - **FIX**: model test error. ([dfaa2cc8](https://github.com/abc873693/ap_common/commit/dfaa2cc87a5667212617d63fe534334fe51fc06b))
 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: `ap_common_core` separate static error. ([177a00fd](https://github.com/abc873693/ap_common/commit/177a00fd613c7d869643f8d2c7ab02bc102fc064))
 - **FEAT**(ui): add HomePageScaffold.fromDataState() and test suite. ([307a296b](https://github.com/abc873693/ap_common/commit/307a296b6fc6268e4a147faa1093d7e9e0a58221))
 - **FEAT**(ui): add simplified UI integration API with DataState sealed class. ([54f566bd](https://github.com/abc873693/ap_common/commit/54f566bd0dc3fe857ef623d5ac8c24e23547f096))
 - **FEAT**: model unit test. ([d3d5de68](https://github.com/abc873693/ap_common/commit/d3d5de688cdba555e2f9ca7e475f031645f578d2))
 - **FEAT**: improve model generate by `freezed`. ([43bef51c](https://github.com/abc873693/ap_common/commit/43bef51c42f8cf8b984074d42c16c403ee83c02c))
 - **FEAT**: `AnalyticsUtil` and `CrashlyticsUtil` migrate to injection version. ([0e8a9aab](https://github.com/abc873693/ap_common/commit/0e8a9aab76b2a6994dbcfdf4814e6f7104e4b312))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([55b2fa00](https://github.com/abc873693/ap_common/commit/55b2fa00ea5fa4dafb15fc19e19b33dd9d72ef92))
 - **FEAT**: migrate `util` `l10n`  to new `ap_common_flutter_core`. ([be152bac](https://github.com/abc873693/ap_common/commit/be152bac1b94f8e80baba9c098a938c44246b810))
 - **FEAT**: centralized package lint rule. ([c2b8ad80](https://github.com/abc873693/ap_common/commit/c2b8ad8000bb19d0d5fccdaf63f0411329e6dcfa))
 - **FEAT**: release `ap_common_core` v0.0.2. ([7eef7658](https://github.com/abc873693/ap_common/commit/7eef76580b57b66dfd78f5692cdc2a8748f575a3))
 - **FEAT**: migrate `NotificationUtil` and `Preference` to injection version. ([4326c12e](https://github.com/abc873693/ap_common/commit/4326c12e28732d86a1b5a0fff2fdd6d3a3c6e5e6))
 - **FEAT**: `ap_common` import `ap_common_core`. ([d463f7c7](https://github.com/abc873693/ap_common/commit/d463f7c7b5cd78c171b90eea0210f81649fc5626))
 - **FEAT**: migrate `model`  `util` `config` to new `ap_common_core`. ([3887bc05](https://github.com/abc873693/ap_common/commit/3887bc05ebf8612f2b2a1cc607ec3c3fdf3135e1))

#### `ap_common_firebase` - `v1.0.1-dev.4`

 - **FIX**: resolve all pre-existing lint issues across packages. ([84db9998](https://github.com/abc873693/ap_common/commit/84db99986ccfac62b720cbf69f03bc021c154bc5))
 - **FIX**(firebase): upgrade firebase deps and adapt to new API. ([7540d9db](https://github.com/abc873693/ap_common/commit/7540d9db6474bef1e6952a72366686389087f2ad))

#### `ap_common_flutter_core` - `v1.1.0-dev.4`

 - **REFACTOR**(l10n): address code review feedback. ([7c7b84e0](https://github.com/abc873693/ap_common/commit/7c7b84e08be6352a3e50d427ce792834c0435a2c))
 - **REFACTOR**(l10n): clean up intl remnants after slang migration. ([ea893e6d](https://github.com/abc873693/ap_common/commit/ea893e6d5b0e0587231cab2741e309da909d5a7b))
 - **REFACTOR**(media): replace GeneralResponseCallback with SaveImageResult sealed class. ([2cfc5176](https://github.com/abc873693/ap_common/commit/2cfc51762e25bc361c1420e405a7c444224477e5))
 - **REFACTOR**(flutter_core): remove GeneralCallback pattern completely. ([e463cf75](https://github.com/abc873693/ap_common/commit/e463cf75723acb18d44e974f1ff9b3e00cccc3d6))
 - **REFACTOR**(announcement): add showErrorToast extension and simplify UI error handling. ([dc46221d](https://github.com/abc873693/ap_common/commit/dc46221d222f1a68a458d6a226d82ccf7bf7049a))
 - **REFACTOR**(l10n): restore original i18n variable naming conventions. ([c21ed521](https://github.com/abc873693/ap_common/commit/c21ed521369b6a3f6030da7ac9a9bae6b97d13dd))
 - **FIX**: resolve all pre-existing lint issues across packages. ([84db9998](https://github.com/abc873693/ap_common/commit/84db99986ccfac62b720cbf69f03bc021c154bc5))
 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: packages version constraint. ([8231a423](https://github.com/abc873693/ap_common/commit/8231a423b237d6f38b3531ec4fc2b06e713a6c51))
 - **FEAT**(l10n): migrate ap_common_flutter_core from intl to slang. ([de440d23](https://github.com/abc873693/ap_common/commit/de440d23f8c8e0276e62e2728a242cb782e05ba7))
 - **FEAT**: update i18n for theme translate. ([2e7e862d](https://github.com/abc873693/ap_common/commit/2e7e862d0f8803d64403c15df67108863a74fb1f))
 - **FEAT**(flutter_core): update `multiple_localization` to any version. ([a4114e01](https://github.com/abc873693/ap_common/commit/a4114e0182568d90603041118d59130fbdbd3aa7))
 - **FEAT**: update GDG on Campus NKUST x ITC information". ([b2e1c200](https://github.com/abc873693/ap_common/commit/b2e1c200374c0090c9888f6642dc1d8a197ed661))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([55b2fa00](https://github.com/abc873693/ap_common/commit/55b2fa00ea5fa4dafb15fc19e19b33dd9d72ef92))
 - **FEAT**: `AppStoreUtil` and `PlatformUtil` for `ap_common_flutter_core`. ([f9abb16d](https://github.com/abc873693/ap_common/commit/f9abb16d2e525ff8d5d4a68cd7a098e8025cd772))
 - **FEAT**: migrate `util` `l10n`  to new `ap_common_flutter_core`. ([be152bac](https://github.com/abc873693/ap_common/commit/be152bac1b94f8e80baba9c098a938c44246b810))

#### `ap_common_flutter_platform` - `v1.0.1-dev.4`

 - **REFACTOR**(platform): use clock package for testable time in notification utils. ([544327a8](https://github.com/abc873693/ap_common/commit/544327a89c570f97f6d28cf234f7b99cb0c944ca))
 - **REFACTOR**(media): replace GeneralResponseCallback with SaveImageResult sealed class. ([2cfc5176](https://github.com/abc873693/ap_common/commit/2cfc51762e25bc361c1420e405a7c444224477e5))
 - **REFACTOR**(l10n): use context-based translation access for reactive locale switching. ([e9429aa1](https://github.com/abc873693/ap_common/commit/e9429aa1bbfc2e97b72e0010d8bebf63777b050d))
 - **REFACTOR**(l10n): restore original i18n variable naming conventions. ([c21ed521](https://github.com/abc873693/ap_common/commit/c21ed521369b6a3f6030da7ac9a9bae6b97d13dd))
 - **REFACTOR**(l10n): update UI packages to use slang translation API. ([697e1e15](https://github.com/abc873693/ap_common/commit/697e1e15b28ab194f71e322da1acf48d14fb2cd2))
 - **REFACTOR**(ui): fix lint errors and improve code quality. ([36a092bd](https://github.com/abc873693/ap_common/commit/36a092bd42002835b5ea2252c15d21f78d39691d))
 - **FIX**(test): suppress depend_on_referenced_packages for intl in notification test. ([28678c77](https://github.com/abc873693/ap_common/commit/28678c77751fdda5003ea158827b98b7f692c41e))
 - **FIX**: resolve all pre-existing lint issues across packages. ([84db9998](https://github.com/abc873693/ap_common/commit/84db99986ccfac62b720cbf69f03bc021c154bc5))
 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: packages version constraint. ([8231a423](https://github.com/abc873693/ap_common/commit/8231a423b237d6f38b3531ec4fc2b06e713a6c51))
 - **FEAT**: upgrade package flutter 3.29 compatible. ([54ae5f08](https://github.com/abc873693/ap_common/commit/54ae5f087f95858e551b0a78008072f74faaa17b))
 - **FEAT**: upgrade package for package `web` 1.0.0. ([c0ac3e33](https://github.com/abc873693/ap_common/commit/c0ac3e331b64a436e909a8ec7ab2983974ae37a4))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([55b2fa00](https://github.com/abc873693/ap_common/commit/55b2fa00ea5fa4dafb15fc19e19b33dd9d72ef92))

#### `ap_common_flutter_ui` - `v1.1.0-dev.4`

 - **REFACTOR**: optimize layout and barcode display for UserInfo Scaffold. ([933cd633](https://github.com/abc873693/ap_common/commit/933cd633d637293920186f8611784566578cc241))
 - **REFACTOR**: migrate to slang i18n and new ApTheme API after rebase on develop. ([80307353](https://github.com/abc873693/ap_common/commit/80307353da283af46cd9e61a578cfbb795b6cdb8))
 - **REFACTOR**(media): replace GeneralResponseCallback with SaveImageResult sealed class. ([2cfc5176](https://github.com/abc873693/ap_common/commit/2cfc51762e25bc361c1420e405a7c444224477e5))
 - **REFACTOR**(l10n): use context-based translation access for reactive locale switching. ([e9429aa1](https://github.com/abc873693/ap_common/commit/e9429aa1bbfc2e97b72e0010d8bebf63777b050d))
 - **REFACTOR**(l10n): restore original i18n variable naming conventions. ([c21ed521](https://github.com/abc873693/ap_common/commit/c21ed521369b6a3f6030da7ac9a9bae6b97d13dd))
 - **REFACTOR**(l10n): update UI packages to use slang translation API. ([697e1e15](https://github.com/abc873693/ap_common/commit/697e1e15b28ab194f71e322da1acf48d14fb2cd2))
 - **REFACTOR**(ui): fix lint errors and improve code quality. ([36a092bd](https://github.com/abc873693/ap_common/commit/36a092bd42002835b5ea2252c15d21f78d39691d))
 - **REFACTOR**(ui): update pages and views with Material 3 components. ([fcb897f0](https://github.com/abc873693/ap_common/commit/fcb897f031ec5fa9d9342477b026aa221900b6da))
 - **REFACTOR**(ui): update scaffolds to use new widgets and Material 3. ([da1b8e0c](https://github.com/abc873693/ap_common/commit/da1b8e0c165ce1d9d9477160a9b15779dddb0855))
 - **REFACTOR**(ui): update utility classes for Material 3 compatibility. ([5fbee088](https://github.com/abc873693/ap_common/commit/5fbee0887fc9e26fdc976b82ddea3bcf5b16e8d8))
 - **REFACTOR**(ui): update scaffolds and views to use Material 3 color schemes. ([7f3e6a1c](https://github.com/abc873693/ap_common/commit/7f3e6a1cb7bbf17b5f9c70274b48577311f9f93d))
 - **REFACTOR**(ui): migrate dialog widgets to Material 3 theme and components. ([34466ce6](https://github.com/abc873693/ap_common/commit/34466ce667cc1c0f098939b9cbd75e18ad530998))
 - **REFACTOR**: optimize UI design for Login and HomePage Scaffolds. ([3aa9190c](https://github.com/abc873693/ap_common/commit/3aa9190c4fc96ec1543a3bb769cf69a9e9012757))
 - **REFACTOR**: optimize UI design for Course and Score Scaffolds. ([b1c3e915](https://github.com/abc873693/ap_common/commit/b1c3e915206e2cc389304e4e234aeed4f97ab6fd))
 - **FIX**: resolve all pre-existing lint issues across packages. ([84db9998](https://github.com/abc873693/ap_common/commit/84db99986ccfac62b720cbf69f03bc021c154bc5))
 - **FIX**: packages version constraint. ([8231a423](https://github.com/abc873693/ap_common/commit/8231a423b237d6f38b3531ec4fc2b06e713a6c51))
 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: resolve analyze errors and lint issues in simplified UI integration. ([d0f2e45e](https://github.com/abc873693/ap_common/commit/d0f2e45eef25441b5786f3e65f4190b4e798b342))
 - **FIX**: `ApAssets` path error. ([558e5445](https://github.com/abc873693/ap_common/commit/558e54451ed7ae1d1d0a9de2e74a8c2172845b9b))
 - **FIX**(test): resolve widget test failures in simplified UI pages. ([12094e48](https://github.com/abc873693/ap_common/commit/12094e48e37baf42f6168c651796a6c253d86639))
 - **FEAT**: add merged course view and optimize table layout density. ([410808a5](https://github.com/abc873693/ap_common/commit/410808a59c1d5cf68999e2deba86b78b7aaff552))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))
 - **FEAT**: score scaffold responsive. ([426678f5](https://github.com/abc873693/ap_common/commit/426678f5d2559179cce9e9b0c5cfb3216147532b))
 - **FEAT**: update i18n for theme translate. ([2e7e862d](https://github.com/abc873693/ap_common/commit/2e7e862d0f8803d64403c15df67108863a74fb1f))
 - **FEAT**: add SemesterPicker and optimize ApUtils and ApDrawer. ([0ebafe0c](https://github.com/abc873693/ap_common/commit/0ebafe0cbe9fb35d2199f79efa633f7c811c90d0))
 - **FEAT**: implement dynamic theme color switching and color picker in settings. ([2dce7929](https://github.com/abc873693/ap_common/commit/2dce792963a6520e221e83dec2ab9081e50d3b14))
 - **FEAT**: improve model generate by `freezed`. ([43bef51c](https://github.com/abc873693/ap_common/commit/43bef51c42f8cf8b984074d42c16c403ee83c02c))
 - **FEAT**(flutter_ui): `PdfView` custom error messageOB. ([0426059d](https://github.com/abc873693/ap_common/commit/0426059d16d364bd6ebf02398ffea13628119c6f))
 - **FEAT**: update GDG on Campus NKUST x ITC information". ([b2e1c200](https://github.com/abc873693/ap_common/commit/b2e1c200374c0090c9888f6642dc1d8a197ed661))
 - **FEAT**: change to material design 3. ([04a13b5d](https://github.com/abc873693/ap_common/commit/04a13b5da516b9cbbc3a56eb29ab670c34653e55))
 - **FEAT**: update float action button can invisible. ([c30380bc](https://github.com/abc873693/ap_common/commit/c30380bc2254fc1fe1ac31deea4c7c62658ae9c8))
 - **FEAT**(ui): add simplified UI integration API with DataState sealed class. ([54f566bd](https://github.com/abc873693/ap_common/commit/54f566bd0dc3fe857ef623d5ac8c24e23547f096))
 - **FEAT**(ui): add HomePageScaffold.fromDataState() and test suite. ([307a296b](https://github.com/abc873693/ap_common/commit/307a296b6fc6268e4a147faa1093d7e9e0a58221))
 - **FEAT**(ui): extract common widgets into separate components. ([fd19e957](https://github.com/abc873693/ap_common/commit/fd19e957372f6266ba8657a2a90800737e760881))

#### `ap_common_plugin` - `v1.0.1-dev.3`

 - **REFACTOR**(l10n): restore original i18n variable naming conventions. ([c21ed521](https://github.com/abc873693/ap_common/commit/c21ed521369b6a3f6030da7ac9a9bae6b97d13dd))
 - **FIX**(ap_common_plugin): android plugin register setting. ([07968966](https://github.com/abc873693/ap_common/commit/07968966be3576952eb924832048e51292a877e4))
 - **FEAT**: upgrade package flutter 3.29 compatible. ([54ae5f08](https://github.com/abc873693/ap_common/commit/54ae5f087f95858e551b0a78008072f74faaa17b))


## 2026-03-29

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common` - `v1.0.1-dev.3`](#ap_common---v101-dev3)
 - [`ap_common_announcement_ui` - `v1.0.1-dev.3`](#ap_common_announcement_ui---v101-dev3)
 - [`ap_common_core` - `v1.0.1-dev.0`](#ap_common_core---v101-dev0)
 - [`ap_common_firebase` - `v1.0.1-dev.3`](#ap_common_firebase---v101-dev3)
 - [`ap_common_flutter_core` - `v1.1.0-dev.3`](#ap_common_flutter_core---v110-dev3)
 - [`ap_common_flutter_platform` - `v1.0.1-dev.3`](#ap_common_flutter_platform---v101-dev3)
 - [`ap_common_flutter_ui` - `v1.1.0-dev.3`](#ap_common_flutter_ui---v110-dev3)
 - [`ap_common_plugin` - `v1.0.1-dev.2`](#ap_common_plugin---v101-dev2)

---

#### `ap_common` - `v1.0.1-dev.3`

 - **REFACTOR**(ui): fix lint errors and improve code quality. ([36a092bd](https://github.com/abc873693/ap_common/commit/36a092bd42002835b5ea2252c15d21f78d39691d))

#### `ap_common_announcement_ui` - `v1.0.1-dev.3`

 - **REFACTOR**(l10n): use context-based translation access for reactive locale switching. ([e9429aa1](https://github.com/abc873693/ap_common/commit/e9429aa1bbfc2e97b72e0010d8bebf63777b050d))
 - **REFACTOR**(l10n): restore original i18n variable naming conventions. ([c21ed521](https://github.com/abc873693/ap_common/commit/c21ed521369b6a3f6030da7ac9a9bae6b97d13dd))
 - **REFACTOR**(l10n): update UI packages to use slang translation API. ([697e1e15](https://github.com/abc873693/ap_common/commit/697e1e15b28ab194f71e322da1acf48d14fb2cd2))
 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: packages version constraint. ([8231a423](https://github.com/abc873693/ap_common/commit/8231a423b237d6f38b3531ec4fc2b06e713a6c51))
 - **FEAT**: improve model generate by `freezed`. ([43bef51c](https://github.com/abc873693/ap_common/commit/43bef51c42f8cf8b984074d42c16c403ee83c02c))
 - **FEAT**: align image upload naming. ([ab2f2492](https://github.com/abc873693/ap_common/commit/ab2f2492f05117a2474357cbd7373498b40df878))
 - **FEAT**: revert imgur implement. ([30bbf5ea](https://github.com/abc873693/ap_common/commit/30bbf5eadc1b05d08f5c269169e9bfe715c5bbb0))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))

#### `ap_common_core` - `v1.0.1-dev.0`

 - **FIX**(firebase): upgrade firebase deps and adapt to new API. ([7540d9db](https://github.com/abc873693/ap_common/commit/7540d9db6474bef1e6952a72366686389087f2ad))

#### `ap_common_firebase` - `v1.0.1-dev.3`

 - **FIX**(firebase): upgrade firebase deps and adapt to new API. ([7540d9db](https://github.com/abc873693/ap_common/commit/7540d9db6474bef1e6952a72366686389087f2ad))

#### `ap_common_flutter_core` - `v1.1.0-dev.3`

 - **REFACTOR**(l10n): restore original i18n variable naming conventions. ([c21ed521](https://github.com/abc873693/ap_common/commit/c21ed521369b6a3f6030da7ac9a9bae6b97d13dd))
 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: packages version constraint. ([8231a423](https://github.com/abc873693/ap_common/commit/8231a423b237d6f38b3531ec4fc2b06e713a6c51))
 - **FEAT**(l10n): migrate ap_common_flutter_core from intl to slang. ([de440d23](https://github.com/abc873693/ap_common/commit/de440d23f8c8e0276e62e2728a242cb782e05ba7))
 - **FEAT**: update i18n for theme translate. ([2e7e862d](https://github.com/abc873693/ap_common/commit/2e7e862d0f8803d64403c15df67108863a74fb1f))
 - **FEAT**(flutter_core): update `multiple_localization` to any version. ([a4114e01](https://github.com/abc873693/ap_common/commit/a4114e0182568d90603041118d59130fbdbd3aa7))
 - **FEAT**: update GDG on Campus NKUST x ITC information". ([b2e1c200](https://github.com/abc873693/ap_common/commit/b2e1c200374c0090c9888f6642dc1d8a197ed661))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([55b2fa00](https://github.com/abc873693/ap_common/commit/55b2fa00ea5fa4dafb15fc19e19b33dd9d72ef92))
 - **FEAT**: `AppStoreUtil` and `PlatformUtil` for `ap_common_flutter_core`. ([f9abb16d](https://github.com/abc873693/ap_common/commit/f9abb16d2e525ff8d5d4a68cd7a098e8025cd772))
 - **FEAT**: migrate `util` `l10n`  to new `ap_common_flutter_core`. ([be152bac](https://github.com/abc873693/ap_common/commit/be152bac1b94f8e80baba9c098a938c44246b810))

#### `ap_common_flutter_platform` - `v1.0.1-dev.3`

 - **REFACTOR**(l10n): use context-based translation access for reactive locale switching. ([e9429aa1](https://github.com/abc873693/ap_common/commit/e9429aa1bbfc2e97b72e0010d8bebf63777b050d))
 - **REFACTOR**(l10n): restore original i18n variable naming conventions. ([c21ed521](https://github.com/abc873693/ap_common/commit/c21ed521369b6a3f6030da7ac9a9bae6b97d13dd))
 - **REFACTOR**(l10n): update UI packages to use slang translation API. ([697e1e15](https://github.com/abc873693/ap_common/commit/697e1e15b28ab194f71e322da1acf48d14fb2cd2))
 - **REFACTOR**(ui): fix lint errors and improve code quality. ([36a092bd](https://github.com/abc873693/ap_common/commit/36a092bd42002835b5ea2252c15d21f78d39691d))
 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: packages version constraint. ([8231a423](https://github.com/abc873693/ap_common/commit/8231a423b237d6f38b3531ec4fc2b06e713a6c51))
 - **FEAT**: upgrade package flutter 3.29 compatible. ([54ae5f08](https://github.com/abc873693/ap_common/commit/54ae5f087f95858e551b0a78008072f74faaa17b))
 - **FEAT**: upgrade package for package `web` 1.0.0. ([c0ac3e33](https://github.com/abc873693/ap_common/commit/c0ac3e331b64a436e909a8ec7ab2983974ae37a4))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([55b2fa00](https://github.com/abc873693/ap_common/commit/55b2fa00ea5fa4dafb15fc19e19b33dd9d72ef92))

#### `ap_common_flutter_ui` - `v1.1.0-dev.3`

 - **REFACTOR**(l10n): use context-based translation access for reactive locale switching. ([e9429aa1](https://github.com/abc873693/ap_common/commit/e9429aa1bbfc2e97b72e0010d8bebf63777b050d))
 - **REFACTOR**(l10n): restore original i18n variable naming conventions. ([c21ed521](https://github.com/abc873693/ap_common/commit/c21ed521369b6a3f6030da7ac9a9bae6b97d13dd))
 - **REFACTOR**(l10n): update UI packages to use slang translation API. ([697e1e15](https://github.com/abc873693/ap_common/commit/697e1e15b28ab194f71e322da1acf48d14fb2cd2))
 - **REFACTOR**(ui): fix lint errors and improve code quality. ([36a092bd](https://github.com/abc873693/ap_common/commit/36a092bd42002835b5ea2252c15d21f78d39691d))
 - **REFACTOR**(ui): update pages and views with Material 3 components. ([fcb897f0](https://github.com/abc873693/ap_common/commit/fcb897f031ec5fa9d9342477b026aa221900b6da))
 - **REFACTOR**(ui): update scaffolds to use new widgets and Material 3. ([da1b8e0c](https://github.com/abc873693/ap_common/commit/da1b8e0c165ce1d9d9477160a9b15779dddb0855))
 - **REFACTOR**(ui): update utility classes for Material 3 compatibility. ([5fbee088](https://github.com/abc873693/ap_common/commit/5fbee0887fc9e26fdc976b82ddea3bcf5b16e8d8))
 - **REFACTOR**(ui): update scaffolds and views to use Material 3 color schemes. ([7f3e6a1c](https://github.com/abc873693/ap_common/commit/7f3e6a1cb7bbf17b5f9c70274b48577311f9f93d))
 - **REFACTOR**(ui): migrate dialog widgets to Material 3 theme and components. ([34466ce6](https://github.com/abc873693/ap_common/commit/34466ce667cc1c0f098939b9cbd75e18ad530998))
 - **REFACTOR**: optimize layout and barcode display for UserInfo Scaffold. ([933cd633](https://github.com/abc873693/ap_common/commit/933cd633d637293920186f8611784566578cc241))
 - **REFACTOR**: optimize UI design for Course and Score Scaffolds. ([b1c3e915](https://github.com/abc873693/ap_common/commit/b1c3e915206e2cc389304e4e234aeed4f97ab6fd))
 - **REFACTOR**: optimize UI design for Login and HomePage Scaffolds. ([3aa9190c](https://github.com/abc873693/ap_common/commit/3aa9190c4fc96ec1543a3bb769cf69a9e9012757))
 - **FIX**: `ApAssets` path error. ([558e5445](https://github.com/abc873693/ap_common/commit/558e54451ed7ae1d1d0a9de2e74a8c2172845b9b))
 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: packages version constraint. ([8231a423](https://github.com/abc873693/ap_common/commit/8231a423b237d6f38b3531ec4fc2b06e713a6c51))
 - **FEAT**: update float action button can invisible. ([c30380bc](https://github.com/abc873693/ap_common/commit/c30380bc2254fc1fe1ac31deea4c7c62658ae9c8))
 - **FEAT**: score scaffold responsive. ([426678f5](https://github.com/abc873693/ap_common/commit/426678f5d2559179cce9e9b0c5cfb3216147532b))
 - **FEAT**: update i18n for theme translate. ([2e7e862d](https://github.com/abc873693/ap_common/commit/2e7e862d0f8803d64403c15df67108863a74fb1f))
 - **FEAT**(ui): extract common widgets into separate components. ([fd19e957](https://github.com/abc873693/ap_common/commit/fd19e957372f6266ba8657a2a90800737e760881))
 - **FEAT**: add merged course view and optimize table layout density. ([410808a5](https://github.com/abc873693/ap_common/commit/410808a59c1d5cf68999e2deba86b78b7aaff552))
 - **FEAT**: add SemesterPicker and optimize ApUtils and ApDrawer. ([0ebafe0c](https://github.com/abc873693/ap_common/commit/0ebafe0cbe9fb35d2199f79efa633f7c811c90d0))
 - **FEAT**: implement dynamic theme color switching and color picker in settings. ([2dce7929](https://github.com/abc873693/ap_common/commit/2dce792963a6520e221e83dec2ab9081e50d3b14))
 - **FEAT**: improve model generate by `freezed`. ([43bef51c](https://github.com/abc873693/ap_common/commit/43bef51c42f8cf8b984074d42c16c403ee83c02c))
 - **FEAT**(flutter_ui): `PdfView` custom error messageOB. ([0426059d](https://github.com/abc873693/ap_common/commit/0426059d16d364bd6ebf02398ffea13628119c6f))
 - **FEAT**: update GDG on Campus NKUST x ITC information". ([b2e1c200](https://github.com/abc873693/ap_common/commit/b2e1c200374c0090c9888f6642dc1d8a197ed661))
 - **FEAT**: change to material design 3. ([04a13b5d](https://github.com/abc873693/ap_common/commit/04a13b5da516b9cbbc3a56eb29ab670c34653e55))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))

#### `ap_common_plugin` - `v1.0.1-dev.2`

 - **REFACTOR**(l10n): restore original i18n variable naming conventions. ([c21ed521](https://github.com/abc873693/ap_common/commit/c21ed521369b6a3f6030da7ac9a9bae6b97d13dd))
 - **FIX**(ap_common_plugin): android plugin register setting. ([07968966](https://github.com/abc873693/ap_common/commit/07968966be3576952eb924832048e51292a877e4))
 - **FEAT**: upgrade package flutter 3.29 compatible. ([54ae5f08](https://github.com/abc873693/ap_common/commit/54ae5f087f95858e551b0a78008072f74faaa17b))


## 2026-03-29

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common` - `v1.0.1-dev.2`](#ap_common---v101-dev2)
 - [`ap_common_announcement_ui` - `v1.0.1-dev.2`](#ap_common_announcement_ui---v101-dev2)
 - [`ap_common_flutter_core` - `v1.1.0-dev.2`](#ap_common_flutter_core---v110-dev2)
 - [`ap_common_flutter_platform` - `v1.0.1-dev.2`](#ap_common_flutter_platform---v101-dev2)
 - [`ap_common_flutter_ui` - `v1.1.0-dev.2`](#ap_common_flutter_ui---v110-dev2)
 - [`ap_common_plugin` - `v1.0.1-dev.1`](#ap_common_plugin---v101-dev1)
 - [`ap_common_firebase` - `v1.0.1-dev.2`](#ap_common_firebase---v101-dev2)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `ap_common_firebase` - `v1.0.1-dev.2`

---

#### `ap_common` - `v1.0.1-dev.2`

 - **REFACTOR**(ui): fix lint errors and improve code quality. ([36a092bd](https://github.com/abc873693/ap_common/commit/36a092bd42002835b5ea2252c15d21f78d39691d))

#### `ap_common_announcement_ui` - `v1.0.1-dev.2`

 - **REFACTOR**(l10n): use context-based translation access for reactive locale switching. ([e9429aa1](https://github.com/abc873693/ap_common/commit/e9429aa1bbfc2e97b72e0010d8bebf63777b050d))
 - **REFACTOR**(l10n): restore original i18n variable naming conventions. ([c21ed521](https://github.com/abc873693/ap_common/commit/c21ed521369b6a3f6030da7ac9a9bae6b97d13dd))
 - **REFACTOR**(l10n): update UI packages to use slang translation API. ([697e1e15](https://github.com/abc873693/ap_common/commit/697e1e15b28ab194f71e322da1acf48d14fb2cd2))
 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: packages version constraint. ([8231a423](https://github.com/abc873693/ap_common/commit/8231a423b237d6f38b3531ec4fc2b06e713a6c51))
 - **FEAT**: improve model generate by `freezed`. ([43bef51c](https://github.com/abc873693/ap_common/commit/43bef51c42f8cf8b984074d42c16c403ee83c02c))
 - **FEAT**: align image upload naming. ([ab2f2492](https://github.com/abc873693/ap_common/commit/ab2f2492f05117a2474357cbd7373498b40df878))
 - **FEAT**: revert imgur implement. ([30bbf5ea](https://github.com/abc873693/ap_common/commit/30bbf5eadc1b05d08f5c269169e9bfe715c5bbb0))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))

#### `ap_common_flutter_core` - `v1.1.0-dev.2`

 - **REFACTOR**(l10n): restore original i18n variable naming conventions. ([c21ed521](https://github.com/abc873693/ap_common/commit/c21ed521369b6a3f6030da7ac9a9bae6b97d13dd))
 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: packages version constraint. ([8231a423](https://github.com/abc873693/ap_common/commit/8231a423b237d6f38b3531ec4fc2b06e713a6c51))
 - **FEAT**(l10n): migrate ap_common_flutter_core from intl to slang. ([de440d23](https://github.com/abc873693/ap_common/commit/de440d23f8c8e0276e62e2728a242cb782e05ba7))
 - **FEAT**: update i18n for theme translate. ([2e7e862d](https://github.com/abc873693/ap_common/commit/2e7e862d0f8803d64403c15df67108863a74fb1f))
 - **FEAT**(flutter_core): update `multiple_localization` to any version. ([a4114e01](https://github.com/abc873693/ap_common/commit/a4114e0182568d90603041118d59130fbdbd3aa7))
 - **FEAT**: update GDG on Campus NKUST x ITC information". ([b2e1c200](https://github.com/abc873693/ap_common/commit/b2e1c200374c0090c9888f6642dc1d8a197ed661))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([55b2fa00](https://github.com/abc873693/ap_common/commit/55b2fa00ea5fa4dafb15fc19e19b33dd9d72ef92))
 - **FEAT**: `AppStoreUtil` and `PlatformUtil` for `ap_common_flutter_core`. ([f9abb16d](https://github.com/abc873693/ap_common/commit/f9abb16d2e525ff8d5d4a68cd7a098e8025cd772))
 - **FEAT**: migrate `util` `l10n`  to new `ap_common_flutter_core`. ([be152bac](https://github.com/abc873693/ap_common/commit/be152bac1b94f8e80baba9c098a938c44246b810))

#### `ap_common_flutter_platform` - `v1.0.1-dev.2`

 - **REFACTOR**(l10n): use context-based translation access for reactive locale switching. ([e9429aa1](https://github.com/abc873693/ap_common/commit/e9429aa1bbfc2e97b72e0010d8bebf63777b050d))
 - **REFACTOR**(l10n): restore original i18n variable naming conventions. ([c21ed521](https://github.com/abc873693/ap_common/commit/c21ed521369b6a3f6030da7ac9a9bae6b97d13dd))
 - **REFACTOR**(l10n): update UI packages to use slang translation API. ([697e1e15](https://github.com/abc873693/ap_common/commit/697e1e15b28ab194f71e322da1acf48d14fb2cd2))
 - **REFACTOR**(ui): fix lint errors and improve code quality. ([36a092bd](https://github.com/abc873693/ap_common/commit/36a092bd42002835b5ea2252c15d21f78d39691d))
 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: packages version constraint. ([8231a423](https://github.com/abc873693/ap_common/commit/8231a423b237d6f38b3531ec4fc2b06e713a6c51))
 - **FEAT**: upgrade package flutter 3.29 compatible. ([54ae5f08](https://github.com/abc873693/ap_common/commit/54ae5f087f95858e551b0a78008072f74faaa17b))
 - **FEAT**: upgrade package for package `web` 1.0.0. ([c0ac3e33](https://github.com/abc873693/ap_common/commit/c0ac3e331b64a436e909a8ec7ab2983974ae37a4))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([55b2fa00](https://github.com/abc873693/ap_common/commit/55b2fa00ea5fa4dafb15fc19e19b33dd9d72ef92))

#### `ap_common_flutter_ui` - `v1.1.0-dev.2`

 - **REFACTOR**(l10n): use context-based translation access for reactive locale switching. ([e9429aa1](https://github.com/abc873693/ap_common/commit/e9429aa1bbfc2e97b72e0010d8bebf63777b050d))
 - **REFACTOR**(l10n): restore original i18n variable naming conventions. ([c21ed521](https://github.com/abc873693/ap_common/commit/c21ed521369b6a3f6030da7ac9a9bae6b97d13dd))
 - **REFACTOR**(l10n): update UI packages to use slang translation API. ([697e1e15](https://github.com/abc873693/ap_common/commit/697e1e15b28ab194f71e322da1acf48d14fb2cd2))
 - **REFACTOR**(ui): fix lint errors and improve code quality. ([36a092bd](https://github.com/abc873693/ap_common/commit/36a092bd42002835b5ea2252c15d21f78d39691d))
 - **REFACTOR**(ui): update pages and views with Material 3 components. ([fcb897f0](https://github.com/abc873693/ap_common/commit/fcb897f031ec5fa9d9342477b026aa221900b6da))
 - **REFACTOR**(ui): update scaffolds to use new widgets and Material 3. ([da1b8e0c](https://github.com/abc873693/ap_common/commit/da1b8e0c165ce1d9d9477160a9b15779dddb0855))
 - **REFACTOR**(ui): update utility classes for Material 3 compatibility. ([5fbee088](https://github.com/abc873693/ap_common/commit/5fbee0887fc9e26fdc976b82ddea3bcf5b16e8d8))
 - **REFACTOR**(ui): update scaffolds and views to use Material 3 color schemes. ([7f3e6a1c](https://github.com/abc873693/ap_common/commit/7f3e6a1cb7bbf17b5f9c70274b48577311f9f93d))
 - **REFACTOR**(ui): migrate dialog widgets to Material 3 theme and components. ([34466ce6](https://github.com/abc873693/ap_common/commit/34466ce667cc1c0f098939b9cbd75e18ad530998))
 - **REFACTOR**: optimize layout and barcode display for UserInfo Scaffold. ([933cd633](https://github.com/abc873693/ap_common/commit/933cd633d637293920186f8611784566578cc241))
 - **REFACTOR**: optimize UI design for Course and Score Scaffolds. ([b1c3e915](https://github.com/abc873693/ap_common/commit/b1c3e915206e2cc389304e4e234aeed4f97ab6fd))
 - **REFACTOR**: optimize UI design for Login and HomePage Scaffolds. ([3aa9190c](https://github.com/abc873693/ap_common/commit/3aa9190c4fc96ec1543a3bb769cf69a9e9012757))
 - **FIX**: `ApAssets` path error. ([558e5445](https://github.com/abc873693/ap_common/commit/558e54451ed7ae1d1d0a9de2e74a8c2172845b9b))
 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: packages version constraint. ([8231a423](https://github.com/abc873693/ap_common/commit/8231a423b237d6f38b3531ec4fc2b06e713a6c51))
 - **FEAT**: update float action button can invisible. ([c30380bc](https://github.com/abc873693/ap_common/commit/c30380bc2254fc1fe1ac31deea4c7c62658ae9c8))
 - **FEAT**: score scaffold responsive. ([426678f5](https://github.com/abc873693/ap_common/commit/426678f5d2559179cce9e9b0c5cfb3216147532b))
 - **FEAT**: update i18n for theme translate. ([2e7e862d](https://github.com/abc873693/ap_common/commit/2e7e862d0f8803d64403c15df67108863a74fb1f))
 - **FEAT**(ui): extract common widgets into separate components. ([fd19e957](https://github.com/abc873693/ap_common/commit/fd19e957372f6266ba8657a2a90800737e760881))
 - **FEAT**: add merged course view and optimize table layout density. ([410808a5](https://github.com/abc873693/ap_common/commit/410808a59c1d5cf68999e2deba86b78b7aaff552))
 - **FEAT**: add SemesterPicker and optimize ApUtils and ApDrawer. ([0ebafe0c](https://github.com/abc873693/ap_common/commit/0ebafe0cbe9fb35d2199f79efa633f7c811c90d0))
 - **FEAT**: implement dynamic theme color switching and color picker in settings. ([2dce7929](https://github.com/abc873693/ap_common/commit/2dce792963a6520e221e83dec2ab9081e50d3b14))
 - **FEAT**: improve model generate by `freezed`. ([43bef51c](https://github.com/abc873693/ap_common/commit/43bef51c42f8cf8b984074d42c16c403ee83c02c))
 - **FEAT**(flutter_ui): `PdfView` custom error messageOB. ([0426059d](https://github.com/abc873693/ap_common/commit/0426059d16d364bd6ebf02398ffea13628119c6f))
 - **FEAT**: update GDG on Campus NKUST x ITC information". ([b2e1c200](https://github.com/abc873693/ap_common/commit/b2e1c200374c0090c9888f6642dc1d8a197ed661))
 - **FEAT**: change to material design 3. ([04a13b5d](https://github.com/abc873693/ap_common/commit/04a13b5da516b9cbbc3a56eb29ab670c34653e55))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))

#### `ap_common_plugin` - `v1.0.1-dev.1`

 - **REFACTOR**(l10n): restore original i18n variable naming conventions. ([c21ed521](https://github.com/abc873693/ap_common/commit/c21ed521369b6a3f6030da7ac9a9bae6b97d13dd))
 - **FIX**(ap_common_plugin): android plugin register setting. ([07968966](https://github.com/abc873693/ap_common/commit/07968966be3576952eb924832048e51292a877e4))
 - **FEAT**: upgrade package flutter 3.29 compatible. ([54ae5f08](https://github.com/abc873693/ap_common/commit/54ae5f087f95858e551b0a78008072f74faaa17b))


## 2026-03-29

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common` - `v1.0.1-dev.1`](#ap_common---v101-dev1)
 - [`ap_common_announcement_ui` - `v1.0.1-dev.1`](#ap_common_announcement_ui---v101-dev1)
 - [`ap_common_flutter_core` - `v1.1.0-dev.1`](#ap_common_flutter_core---v110-dev1)
 - [`ap_common_flutter_platform` - `v1.0.1-dev.1`](#ap_common_flutter_platform---v101-dev1)
 - [`ap_common_flutter_ui` - `v1.1.0-dev.1`](#ap_common_flutter_ui---v110-dev1)
 - [`ap_common_plugin` - `v1.0.1-dev.0`](#ap_common_plugin---v101-dev0)
 - [`ap_common_firebase` - `v1.0.1-dev.1`](#ap_common_firebase---v101-dev1)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `ap_common_firebase` - `v1.0.1-dev.1`

---

#### `ap_common` - `v1.0.1-dev.1`

 - **REFACTOR**(ui): fix lint errors and improve code quality. ([36a092bd](https://github.com/abc873693/ap_common/commit/36a092bd42002835b5ea2252c15d21f78d39691d))

#### `ap_common_announcement_ui` - `v1.0.1-dev.1`

 - **REFACTOR**(l10n): use context-based translation access for reactive locale switching. ([e9429aa1](https://github.com/abc873693/ap_common/commit/e9429aa1bbfc2e97b72e0010d8bebf63777b050d))
 - **REFACTOR**(l10n): restore original i18n variable naming conventions. ([c21ed521](https://github.com/abc873693/ap_common/commit/c21ed521369b6a3f6030da7ac9a9bae6b97d13dd))
 - **REFACTOR**(l10n): update UI packages to use slang translation API. ([697e1e15](https://github.com/abc873693/ap_common/commit/697e1e15b28ab194f71e322da1acf48d14fb2cd2))
 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: packages version constraint. ([8231a423](https://github.com/abc873693/ap_common/commit/8231a423b237d6f38b3531ec4fc2b06e713a6c51))
 - **FEAT**: improve model generate by `freezed`. ([43bef51c](https://github.com/abc873693/ap_common/commit/43bef51c42f8cf8b984074d42c16c403ee83c02c))
 - **FEAT**: align image upload naming. ([ab2f2492](https://github.com/abc873693/ap_common/commit/ab2f2492f05117a2474357cbd7373498b40df878))
 - **FEAT**: revert imgur implement. ([30bbf5ea](https://github.com/abc873693/ap_common/commit/30bbf5eadc1b05d08f5c269169e9bfe715c5bbb0))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))

#### `ap_common_flutter_core` - `v1.1.0-dev.1`

 - **REFACTOR**(l10n): restore original i18n variable naming conventions. ([c21ed521](https://github.com/abc873693/ap_common/commit/c21ed521369b6a3f6030da7ac9a9bae6b97d13dd))
 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: packages version constraint. ([8231a423](https://github.com/abc873693/ap_common/commit/8231a423b237d6f38b3531ec4fc2b06e713a6c51))
 - **FEAT**(l10n): migrate ap_common_flutter_core from intl to slang. ([de440d23](https://github.com/abc873693/ap_common/commit/de440d23f8c8e0276e62e2728a242cb782e05ba7))
 - **FEAT**: update i18n for theme translate. ([2e7e862d](https://github.com/abc873693/ap_common/commit/2e7e862d0f8803d64403c15df67108863a74fb1f))
 - **FEAT**(flutter_core): update `multiple_localization` to any version. ([a4114e01](https://github.com/abc873693/ap_common/commit/a4114e0182568d90603041118d59130fbdbd3aa7))
 - **FEAT**: update GDG on Campus NKUST x ITC information". ([b2e1c200](https://github.com/abc873693/ap_common/commit/b2e1c200374c0090c9888f6642dc1d8a197ed661))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([55b2fa00](https://github.com/abc873693/ap_common/commit/55b2fa00ea5fa4dafb15fc19e19b33dd9d72ef92))
 - **FEAT**: `AppStoreUtil` and `PlatformUtil` for `ap_common_flutter_core`. ([f9abb16d](https://github.com/abc873693/ap_common/commit/f9abb16d2e525ff8d5d4a68cd7a098e8025cd772))
 - **FEAT**: migrate `util` `l10n`  to new `ap_common_flutter_core`. ([be152bac](https://github.com/abc873693/ap_common/commit/be152bac1b94f8e80baba9c098a938c44246b810))

#### `ap_common_flutter_platform` - `v1.0.1-dev.1`

 - **REFACTOR**(l10n): use context-based translation access for reactive locale switching. ([e9429aa1](https://github.com/abc873693/ap_common/commit/e9429aa1bbfc2e97b72e0010d8bebf63777b050d))
 - **REFACTOR**(l10n): restore original i18n variable naming conventions. ([c21ed521](https://github.com/abc873693/ap_common/commit/c21ed521369b6a3f6030da7ac9a9bae6b97d13dd))
 - **REFACTOR**(l10n): update UI packages to use slang translation API. ([697e1e15](https://github.com/abc873693/ap_common/commit/697e1e15b28ab194f71e322da1acf48d14fb2cd2))
 - **REFACTOR**(ui): fix lint errors and improve code quality. ([36a092bd](https://github.com/abc873693/ap_common/commit/36a092bd42002835b5ea2252c15d21f78d39691d))
 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: packages version constraint. ([8231a423](https://github.com/abc873693/ap_common/commit/8231a423b237d6f38b3531ec4fc2b06e713a6c51))
 - **FEAT**: upgrade package flutter 3.29 compatible. ([54ae5f08](https://github.com/abc873693/ap_common/commit/54ae5f087f95858e551b0a78008072f74faaa17b))
 - **FEAT**: upgrade package for package `web` 1.0.0. ([c0ac3e33](https://github.com/abc873693/ap_common/commit/c0ac3e331b64a436e909a8ec7ab2983974ae37a4))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([55b2fa00](https://github.com/abc873693/ap_common/commit/55b2fa00ea5fa4dafb15fc19e19b33dd9d72ef92))

#### `ap_common_flutter_ui` - `v1.1.0-dev.1`

 - **REFACTOR**(l10n): use context-based translation access for reactive locale switching. ([e9429aa1](https://github.com/abc873693/ap_common/commit/e9429aa1bbfc2e97b72e0010d8bebf63777b050d))
 - **REFACTOR**(l10n): restore original i18n variable naming conventions. ([c21ed521](https://github.com/abc873693/ap_common/commit/c21ed521369b6a3f6030da7ac9a9bae6b97d13dd))
 - **REFACTOR**(l10n): update UI packages to use slang translation API. ([697e1e15](https://github.com/abc873693/ap_common/commit/697e1e15b28ab194f71e322da1acf48d14fb2cd2))
 - **REFACTOR**(ui): fix lint errors and improve code quality. ([36a092bd](https://github.com/abc873693/ap_common/commit/36a092bd42002835b5ea2252c15d21f78d39691d))
 - **REFACTOR**(ui): update pages and views with Material 3 components. ([fcb897f0](https://github.com/abc873693/ap_common/commit/fcb897f031ec5fa9d9342477b026aa221900b6da))
 - **REFACTOR**(ui): update scaffolds to use new widgets and Material 3. ([da1b8e0c](https://github.com/abc873693/ap_common/commit/da1b8e0c165ce1d9d9477160a9b15779dddb0855))
 - **REFACTOR**(ui): update utility classes for Material 3 compatibility. ([5fbee088](https://github.com/abc873693/ap_common/commit/5fbee0887fc9e26fdc976b82ddea3bcf5b16e8d8))
 - **REFACTOR**(ui): update scaffolds and views to use Material 3 color schemes. ([7f3e6a1c](https://github.com/abc873693/ap_common/commit/7f3e6a1cb7bbf17b5f9c70274b48577311f9f93d))
 - **REFACTOR**(ui): migrate dialog widgets to Material 3 theme and components. ([34466ce6](https://github.com/abc873693/ap_common/commit/34466ce667cc1c0f098939b9cbd75e18ad530998))
 - **REFACTOR**: optimize layout and barcode display for UserInfo Scaffold. ([933cd633](https://github.com/abc873693/ap_common/commit/933cd633d637293920186f8611784566578cc241))
 - **REFACTOR**: optimize UI design for Course and Score Scaffolds. ([b1c3e915](https://github.com/abc873693/ap_common/commit/b1c3e915206e2cc389304e4e234aeed4f97ab6fd))
 - **REFACTOR**: optimize UI design for Login and HomePage Scaffolds. ([3aa9190c](https://github.com/abc873693/ap_common/commit/3aa9190c4fc96ec1543a3bb769cf69a9e9012757))
 - **FIX**: `ApAssets` path error. ([558e5445](https://github.com/abc873693/ap_common/commit/558e54451ed7ae1d1d0a9de2e74a8c2172845b9b))
 - **FIX**: pub publish requirement. ([1dc81f7d](https://github.com/abc873693/ap_common/commit/1dc81f7dcf5a1445aa14b66b6d2004b7d94ad6b2))
 - **FIX**: packages version constraint. ([8231a423](https://github.com/abc873693/ap_common/commit/8231a423b237d6f38b3531ec4fc2b06e713a6c51))
 - **FEAT**: update float action button can invisible. ([c30380bc](https://github.com/abc873693/ap_common/commit/c30380bc2254fc1fe1ac31deea4c7c62658ae9c8))
 - **FEAT**: score scaffold responsive. ([426678f5](https://github.com/abc873693/ap_common/commit/426678f5d2559179cce9e9b0c5cfb3216147532b))
 - **FEAT**: update i18n for theme translate. ([2e7e862d](https://github.com/abc873693/ap_common/commit/2e7e862d0f8803d64403c15df67108863a74fb1f))
 - **FEAT**(ui): extract common widgets into separate components. ([fd19e957](https://github.com/abc873693/ap_common/commit/fd19e957372f6266ba8657a2a90800737e760881))
 - **FEAT**: add merged course view and optimize table layout density. ([410808a5](https://github.com/abc873693/ap_common/commit/410808a59c1d5cf68999e2deba86b78b7aaff552))
 - **FEAT**: add SemesterPicker and optimize ApUtils and ApDrawer. ([0ebafe0c](https://github.com/abc873693/ap_common/commit/0ebafe0cbe9fb35d2199f79efa633f7c811c90d0))
 - **FEAT**: implement dynamic theme color switching and color picker in settings. ([2dce7929](https://github.com/abc873693/ap_common/commit/2dce792963a6520e221e83dec2ab9081e50d3b14))
 - **FEAT**: improve model generate by `freezed`. ([43bef51c](https://github.com/abc873693/ap_common/commit/43bef51c42f8cf8b984074d42c16c403ee83c02c))
 - **FEAT**(flutter_ui): `PdfView` custom error messageOB. ([0426059d](https://github.com/abc873693/ap_common/commit/0426059d16d364bd6ebf02398ffea13628119c6f))
 - **FEAT**: update GDG on Campus NKUST x ITC information". ([b2e1c200](https://github.com/abc873693/ap_common/commit/b2e1c200374c0090c9888f6642dc1d8a197ed661))
 - **FEAT**: change to material design 3. ([04a13b5d](https://github.com/abc873693/ap_common/commit/04a13b5da516b9cbbc3a56eb29ab670c34653e55))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([803b2dcb](https://github.com/abc873693/ap_common/commit/803b2dcbb37d970de803670c7a76404356c4a651))

#### `ap_common_plugin` - `v1.0.1-dev.0`

 - **REFACTOR**(l10n): restore original i18n variable naming conventions. ([c21ed521](https://github.com/abc873693/ap_common/commit/c21ed521369b6a3f6030da7ac9a9bae6b97d13dd))


## 2026-03-19

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common` - `v1.0.1-dev.0`](#ap_common---v101-dev0)
 - [`ap_common_flutter_core` - `v1.1.0-dev.0`](#ap_common_flutter_core---v110-dev0)
 - [`ap_common_flutter_platform` - `v1.0.1-dev.0`](#ap_common_flutter_platform---v101-dev0)
 - [`ap_common_flutter_ui` - `v1.1.0-dev.0`](#ap_common_flutter_ui---v110-dev0)
 - [`ap_common_firebase` - `v1.0.1-dev.0`](#ap_common_firebase---v101-dev0)
 - [`ap_common_announcement_ui` - `v1.0.1-dev.0`](#ap_common_announcement_ui---v101-dev0)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `ap_common_firebase` - `v1.0.1-dev.0`
 - `ap_common_announcement_ui` - `v1.0.1-dev.0`

---

#### `ap_common` - `v1.0.1-dev.0`

 - **REFACTOR**(ui): fix lint errors and improve code quality. ([36a092bd](https://github.com/abc873693/ap_common/commit/36a092bd42002835b5ea2252c15d21f78d39691d))

#### `ap_common_flutter_core` - `v1.1.0-dev.0`

 - **FEAT**: update i18n for theme translate. ([2e7e862d](https://github.com/abc873693/ap_common/commit/2e7e862d0f8803d64403c15df67108863a74fb1f))

#### `ap_common_flutter_platform` - `v1.0.1-dev.0`

 - **REFACTOR**(ui): fix lint errors and improve code quality. ([36a092bd](https://github.com/abc873693/ap_common/commit/36a092bd42002835b5ea2252c15d21f78d39691d))

#### `ap_common_flutter_ui` - `v1.1.0-dev.0`

 - **REFACTOR**(ui): fix lint errors and improve code quality. ([36a092bd](https://github.com/abc873693/ap_common/commit/36a092bd42002835b5ea2252c15d21f78d39691d))
 - **REFACTOR**(ui): update pages and views with Material 3 components. ([fcb897f0](https://github.com/abc873693/ap_common/commit/fcb897f031ec5fa9d9342477b026aa221900b6da))
 - **REFACTOR**(ui): update scaffolds to use new widgets and Material 3. ([da1b8e0c](https://github.com/abc873693/ap_common/commit/da1b8e0c165ce1d9d9477160a9b15779dddb0855))
 - **REFACTOR**(ui): update utility classes for Material 3 compatibility. ([5fbee088](https://github.com/abc873693/ap_common/commit/5fbee0887fc9e26fdc976b82ddea3bcf5b16e8d8))
 - **REFACTOR**(ui): update scaffolds and views to use Material 3 color schemes. ([7f3e6a1c](https://github.com/abc873693/ap_common/commit/7f3e6a1cb7bbf17b5f9c70274b48577311f9f93d))
 - **REFACTOR**(ui): migrate dialog widgets to Material 3 theme and components. ([34466ce6](https://github.com/abc873693/ap_common/commit/34466ce667cc1c0f098939b9cbd75e18ad530998))
 - **REFACTOR**: optimize layout and barcode display for UserInfo Scaffold. ([933cd633](https://github.com/abc873693/ap_common/commit/933cd633d637293920186f8611784566578cc241))
 - **REFACTOR**: optimize UI design for Course and Score Scaffolds. ([b1c3e915](https://github.com/abc873693/ap_common/commit/b1c3e915206e2cc389304e4e234aeed4f97ab6fd))
 - **REFACTOR**: optimize UI design for Login and HomePage Scaffolds. ([3aa9190c](https://github.com/abc873693/ap_common/commit/3aa9190c4fc96ec1543a3bb769cf69a9e9012757))
 - **FEAT**: update float action button can invisible. ([c30380bc](https://github.com/abc873693/ap_common/commit/c30380bc2254fc1fe1ac31deea4c7c62658ae9c8))
 - **FEAT**: score scaffold responsive. ([426678f5](https://github.com/abc873693/ap_common/commit/426678f5d2559179cce9e9b0c5cfb3216147532b))
 - **FEAT**: update i18n for theme translate. ([2e7e862d](https://github.com/abc873693/ap_common/commit/2e7e862d0f8803d64403c15df67108863a74fb1f))
 - **FEAT**(ui): extract common widgets into separate components. ([fd19e957](https://github.com/abc873693/ap_common/commit/fd19e957372f6266ba8657a2a90800737e760881))
 - **FEAT**: add merged course view and optimize table layout density. ([410808a5](https://github.com/abc873693/ap_common/commit/410808a59c1d5cf68999e2deba86b78b7aaff552))
 - **FEAT**: add SemesterPicker and optimize ApUtils and ApDrawer. ([0ebafe0c](https://github.com/abc873693/ap_common/commit/0ebafe0cbe9fb35d2199f79efa633f7c811c90d0))
 - **FEAT**: implement dynamic theme color switching and color picker in settings. ([2dce7929](https://github.com/abc873693/ap_common/commit/2dce792963a6520e221e83dec2ab9081e50d3b14))


## 2026-03-16

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common` - `v1.0.0`](#ap_common---v100)
 - [`ap_common_announcement_ui` - `v1.0.0`](#ap_common_announcement_ui---v100)
 - [`ap_common_core` - `v1.0.0`](#ap_common_core---v100)
 - [`ap_common_firebase` - `v1.0.0`](#ap_common_firebase---v100)
 - [`ap_common_flutter_core` - `v1.0.0`](#ap_common_flutter_core---v100)
 - [`ap_common_flutter_platform` - `v1.0.0`](#ap_common_flutter_platform---v100)
 - [`ap_common_flutter_ui` - `v1.0.0`](#ap_common_flutter_ui---v100)
 - [`ap_common_plugin` - `v1.0.0`](#ap_common_plugin---v100)

---

#### `ap_common` - `v1.0.0`

 - Bump "ap_common" to `1.0.0`.

#### `ap_common_announcement_ui` - `v1.0.0`

 - **FEAT**: improve model generate by `freezed`. ([43bef51c](https://github.com/abc873693/ap_common/commit/43bef51c42f8cf8b984074d42c16c403ee83c02c))

#### `ap_common_core` - `v1.0.0`

 - **FIX**: model test error. ([dfaa2cc8](https://github.com/abc873693/ap_common/commit/dfaa2cc87a5667212617d63fe534334fe51fc06b))
 - **FEAT**: model unit test. ([d3d5de68](https://github.com/abc873693/ap_common/commit/d3d5de688cdba555e2f9ca7e475f031645f578d2))
 - **FEAT**: improve model generate by `freezed`. ([43bef51c](https://github.com/abc873693/ap_common/commit/43bef51c42f8cf8b984074d42c16c403ee83c02c))

#### `ap_common_firebase` - `v1.0.0`

#### `ap_common_flutter_core` - `v1.0.0`

 - Bump "ap_common_flutter_core" to `1.0.0`.

#### `ap_common_flutter_platform` - `v1.0.0`

#### `ap_common_flutter_ui` - `v1.0.0`

 - **FEAT**: improve model generate by `freezed`. ([43bef51c](https://github.com/abc873693/ap_common/commit/43bef51c42f8cf8b984074d42c16c403ee83c02c))

#### `ap_common_plugin` - `v1.0.0`


## 2025-09-30

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common_announcement_ui` - `v0.0.4`](#ap_common_announcement_ui---v004)
 - [`ap_common_flutter_ui` - `v0.0.6`](#ap_common_flutter_ui---v006)
 - [`ap_common` - `v0.26.0+3`](#ap_common---v02603)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `ap_common` - `v0.26.0+3`

---

#### `ap_common_announcement_ui` - `v0.0.4`

 - **FEAT**: align image upload naming. ([ab2f2492](https://github.com/abc873693/ap_common/commit/ab2f2492f05117a2474357cbd7373498b40df878))
 - **FEAT**: revert imgur implement. ([30bbf5ea](https://github.com/abc873693/ap_common/commit/30bbf5eadc1b05d08f5c269169e9bfe715c5bbb0))

#### `ap_common_flutter_ui` - `v0.0.6`

 - **FEAT**: change to material design 3. ([04a13b5d](https://github.com/abc873693/ap_common/commit/04a13b5da516b9cbbc3a56eb29ab670c34653e55))


## 2025-09-21

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common_flutter_ui` - `v0.0.5`](#ap_common_flutter_ui---v005)
 - [`ap_common` - `v0.26.0+2`](#ap_common---v02602)
 - [`ap_common_announcement_ui` - `v0.0.3+2`](#ap_common_announcement_ui---v0032)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `ap_common` - `v0.26.0+2`
 - `ap_common_announcement_ui` - `v0.0.3+2`

---

#### `ap_common_flutter_ui` - `v0.0.5`

 - **FEAT**(flutter_ui): `PdfView` custom error messageOB. ([0426059d](https://github.com/abc873693/ap_common/commit/0426059d16d364bd6ebf02398ffea13628119c6f))


## 2025-09-21

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common_flutter_core` - `v0.0.4`](#ap_common_flutter_core---v004)
 - [`ap_common_flutter_platform` - `v0.0.5`](#ap_common_flutter_platform---v005)
 - [`ap_common_flutter_ui` - `v0.0.4`](#ap_common_flutter_ui---v004)
 - [`ap_common_plugin` - `v0.5.1`](#ap_common_plugin---v051)
 - [`ap_common_firebase` - `v0.17.0+1`](#ap_common_firebase---v01701)
 - [`ap_common_announcement_ui` - `v0.0.3+1`](#ap_common_announcement_ui---v0031)
 - [`ap_common` - `v0.26.0+1`](#ap_common---v02601)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `ap_common_firebase` - `v0.17.0+1`
 - `ap_common_announcement_ui` - `v0.0.3+1`
 - `ap_common` - `v0.26.0+1`

---

#### `ap_common_flutter_core` - `v0.0.4`

 - **FEAT**(flutter_core): update `multiple_localization` to any version. ([a4114e01](https://github.com/abc873693/ap_common/commit/a4114e0182568d90603041118d59130fbdbd3aa7))
 - **FEAT**: update GDG on Campus NKUST x ITC information". ([b2e1c200](https://github.com/abc873693/ap_common/commit/b2e1c200374c0090c9888f6642dc1d8a197ed661))

#### `ap_common_flutter_platform` - `v0.0.5`

 - **FEAT**: upgrade package flutter 3.29 compatible. ([54ae5f08](https://github.com/abc873693/ap_common/commit/54ae5f087f95858e551b0a78008072f74faaa17b))

#### `ap_common_flutter_ui` - `v0.0.4`

 - **FEAT**: update GDG on Campus NKUST x ITC information". ([b2e1c200](https://github.com/abc873693/ap_common/commit/b2e1c200374c0090c9888f6642dc1d8a197ed661))

#### `ap_common_plugin` - `v0.5.1`

 - **FIX**(ap_common_plugin): android plugin register setting. ([07968966](https://github.com/abc873693/ap_common/commit/07968966be3576952eb924832048e51292a877e4))
 - **FEAT**: upgrade package flutter 3.29 compatible. ([54ae5f08](https://github.com/abc873693/ap_common/commit/54ae5f087f95858e551b0a78008072f74faaa17b))


## 2025-02-27

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common_plugin` - `v0.5.0-dev.4`](#ap_common_plugin---v050-dev4)

---

#### `ap_common_plugin` - `v0.5.0-dev.4`

 - fix(ap_common_plugin): android plugin register setting

 - **FIX**(ap_common_plugin): android plugin register setting. ([07968966](https://github.com/abc873693/ap_common/commit/07968966be3576952eb924832048e51292a877e4))
 - **FEAT**(ap_common_plugin): update iOS setting for flutter 3.27 create. ([e65572db](https://github.com/abc873693/ap_common/commit/e65572dbd5f92b22612b4e7b4295aeca6b3bf42e))
 - **FEAT**(ap_common_plugin): upgrade gradle 8 setting for android 15. ([862d08af](https://github.com/abc873693/ap_common/commit/862d08af7006fa55ad42b23f9395cf95aed07916))


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

