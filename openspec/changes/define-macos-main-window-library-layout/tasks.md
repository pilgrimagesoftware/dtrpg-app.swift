## 1. macOS Layout Spec

- [x] 1.1 Add Swift child change for AppKit main-window library layout behavior
- [x] 1.2 Add `macos-main-window-library-layout` capability delta spec

## 2. AppKit Implementation Planning

- [ ] 2.1 Define AppKit view/controller boundaries for the disclosable search/filter area
- [ ] 2.2 Define AppKit account menu actions for account identity, token set/reset, and settings navigation
- [ ] 2.3 Define shared macOS browsing state for list/tree and grid presentations
- [ ] 2.4 Define macOS sync status and thumbnail loading state that update without blocking the main window
- [ ] 2.5 Verify no SwiftUI usage is introduced

## 3. Verification

- [ ] 3.1 Verify expanded and collapsed filter states preserve active browsing state
- [ ] 3.2 Verify list/tree and grid views share matched items and summary counts
- [ ] 3.3 Verify account menu avoids passive raw token disclosure
- [ ] 3.4 Verify sync status and thumbnail loading do not block main-window interaction
