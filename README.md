# The Luisville Journal – Supabase + GitHub Pages

## 1. Supabase (free plan, sign up with GitHub or email)
1. https://supabase.com → **New project** (any name/password/region).
2. **SQL Editor → New query** → paste `setup.sql` → **Run**.
3. **Authentication → Sign In / Providers → "Allow anonymous sign-ins" → ON** → Save.
4. **Project Settings → API**: copy the **Project URL** and the **anon public key**.
5. Paste them at the top of `index.html` (`SUPABASE_URL`, `SUPABASE_KEY`). The anon key is meant to be public.

## 2. GitHub Pages
1. Upload everything (including the `.github` folder) to a repository.
2. **Settings → Pages → Deploy from a branch → main / root.**

## 3. Keep the project awake (free plan pauses after 7 idle days)
Repo **Settings → Secrets and variables → Actions → New secret**:
`SUPABASE_URL` and `SUPABASE_ANON_KEY` (same values as above). The workflow then pings the database every 3 days.
GitHub stops scheduled jobs after 60 days without repo activity: just open the Actions tab and re-enable it if that happens.

The writer code (`dngjournal`) is checked inside the database (see `setup.sql`), not in the site's code. Issues older than 7 days are deleted automatically.
