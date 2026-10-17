# The Luisville Journal – setup (Firebase + GitHub Pages)

## 1. Firebase (free "Spark" plan)
1. Go to https://console.firebase.google.com → **Add project** (disable Google Analytics).
2. **Build → Firestore Database → Create database** (production mode, any region).
3. **Firestore → Rules**: paste the content of `firestore.rules` → **Publish**.
4. **Build → Authentication → Get started → Sign-in method → Anonymous → Enable.**
5. **Project settings (gear) → Your apps → `</>` Web app** → register → copy the `firebaseConfig` values.
6. Open `index.html` and paste them at the top (`firebaseConfig`).

## 2. GitHub Pages
1. Create a repository, upload `index.html` (and these files if you wish).
2. **Settings → Pages → Deploy from a branch → main / root.**
3. Back in Firebase: **Authentication → Settings → Authorized domains → Add** `YOURNAME.github.io`.

## Notes
- The writer code (`dngjournal`) is checked by Firestore rules, so it is not visible in the site's code. To change it, edit it in `firestore.rules` and re-publish.
- Issues older than 7 days are deleted automatically when anyone opens the site.
