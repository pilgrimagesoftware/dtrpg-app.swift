## 1. Structure Spec

- [x] 1.1 Add `macos-main-window-structure` capability delta spec
- [x] 1.2 Confirm this change supersedes the remaining search/filter and account-menu tasks in
      `define-macos-main-window-library-layout`

## 2. Title Bar

- [ ] 2.1 Implement the title bar region with separator, title, and account button
- [ ] 2.2 Implement the account menu with user info, settings, and sign-out

## 3. Sidebar

- [ ] 3.1 Implement the collapsible sidebar with default section counts
- [ ] 3.2 Implement the Collections section (count, search, add, collapse)
- [ ] 3.3 Implement the Publishers section (count, search, collapse)

## 4. Tabs

- [ ] 4.1 Implement the tab strip with overflow "more" menu
- [ ] 4.2 Implement the non-closable catalog tab with search/sort/view mode header
- [ ] 4.3 Implement single-click popover detail
- [ ] 4.4 Implement double-click expanded detail tab with thumbnail, attributes, and file list

## 5. Status Bar

- [ ] 5.1 Implement the status bar with library totals and active-tab summary
- [ ] 5.2 Implement the theme picker
- [ ] 5.3 Implement the activity indicator
- [ ] 5.4 Implement the notification indicator

## 6. Verification

- [ ] 6.1 Verify compatibility with `library-view-state` and `macos-auth-session-management`
- [ ] 6.2 Verify tab overflow, popover/tab distinction, and status bar sync with sidebar/catalog
      state
