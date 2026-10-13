# Attendly — Personal Attendance Tracker

A responsive dark-blue attendance tracker starter. It includes account sign-in/sign-up, cloud-saved subjects, daily Present/Absent/Leave status, automatic percentages, attendance history, and CSV export.

## 1. Configure cloud storage (Supabase)

1. Create a free project at https://supabase.com and wait for provisioning.
2. Open **SQL Editor → New query** in your Supabase project.
3. Copy all of `schema.sql` into the editor and run it.
4. Open **Project Settings → API** (or API Keys). Copy the **Project URL** and the **anon/public** key.
5. Edit `config.js` and replace `YOUR_PROJECT_URL` and `YOUR_SUPABASE_ANON_KEY`.
   - Use only the anon/public key in this browser app.
   - Never paste a `service_role` key into frontend code.
6. In Supabase **Authentication → URL Configuration**, set your local development URL and the deployed site URL in the allowed redirect/site URL settings as appropriate.
7. For easiest first test, run a local web server in this folder (opening index.html directly as a file may cause browser restrictions):
   - Python: `python -m http.server 8000`
   - Visit `http://localhost:8000`
8. Create an account. If email confirmation is enabled, confirm the email before signing in.

## 2. Put it online

You can deploy this folder using a static host such as Netlify, Cloudflare Pages, or GitHub Pages. Upload `index.html` and `config.js` (and optionally README/schema for your own records). Set the deployed URL in Supabase Auth URL Configuration.

## Security notes

- Row Level Security (RLS) policies in `schema.sql` restrict each signed-in user to their own subjects and attendance.
- The browser app uses the anon/public key, never the service-role key.
- Use a strong unique password; enable email confirmation if desired.
- This is a starter project, not an audited production system. Test sign-up, sign-in, row-level access, and backups before relying on it for important records.

## Attendance calculation

Attendance percentage = Present ÷ (Present + Absent) × 100. Leave entries are recorded in history but excluded from the percentage denominator.
