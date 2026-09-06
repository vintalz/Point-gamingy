# QuestOS

A personal gamification dashboard with:
- Daily schedules worth 20 points each
- Monday–Sunday recurring weekly schedules
- Side quests organized by category
- Point shop with automatic subtraction
- Daily / weekly / lifetime statistics
- Improvement tracking
- Automatic local version snapshots
- JSON export/import backups
- Local accounts for testing
- Optional Supabase authentication/database for real multi-device accounts

## Fastest way to test
Open `index.html` in a browser. No server is required for local demo mode.

## Real accounts / multiple users
1. Create a Supabase project.
2. Run `supabase_schema.sql` in Supabase SQL Editor.
3. Enable Email authentication.
4. Put your Supabase URL and anon key into `index.html`:
   SUPABASE_URL="..."
   SUPABASE_ANON_KEY="..."
5. Deploy `index.html` to GitHub Pages.

Important: never put a Supabase service-role key in this website. Only the public anon key belongs in frontend code.

## Important limitation
The blank-config local mode is NOT a real online account system. Its users, points and backups exist only in that browser. Supabase mode is what makes accounts and data persist across devices.
