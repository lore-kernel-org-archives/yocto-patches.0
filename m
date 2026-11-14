Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3815.1794687599504479739
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 14 Nov 2026 12:19:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=vEx8ft2u;
 spf=pass (domain: gmail.com, ip: 209.85.215.176, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdddc79a4afso564967a12.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 12:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794687599; x=1795292399; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aW9conoQeVs6HaYdBgPzTa7aeHt6J/9xOUuTLa29Q/0=;
        b=vEx8ft2uaywoFGxDUJIimIBJdKkwdf5tVkiENvPxS9BDrePclueJyjk3rzrfETOrYZ
         xFkx0AZW4lOYAQtk/2T0nyjoZtVHKkK1LBbdtw5bxrwVNv/ffcVm2oCMuVh0qeAytQ33
         uf5qFqzDV9fdh5f+GKs9XjlLhIM9cILQl7PAncfeZSLtcjaQSDimMd6vCu669Uxh7emR
         Haqf1hHro6HxFfpRSzx56PCvv6O8bM05kYN7ws4jynKOg4i4l78tXPadFM211s7WopzX
         xhs8zMLM4WH0Qmu7uTq0VSRHvrdMVzb5bEU9/jbLpHWqihNr33NrmO0rnb42TbFlx83F
         jjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794687599; x=1795292399;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aW9conoQeVs6HaYdBgPzTa7aeHt6J/9xOUuTLa29Q/0=;
        b=emRjVz63yaWDKCszKH1KjGn5r0MSbpRilLJBbA5sITVxpUo/GOHdzLoyFLV3bv9aVy
         CMY+K68yIunWRpCmgWxpB7oWFxk5K0mJfuYdFGG9ClH71H+Rw0k+dtvkFZtiFuE8api6
         vVeXWCqbknUc9KVX+jHBi2fmI6AmM1ZkUpCqqgKRTzqsHp/BYASraadJfyy2u5dXscAC
         oHuS6ZoExmsH54ecFvkptMTNCKJhVwO09vgFbQDzYIgrn7Urvxc1tF7y9DnVqYpCB0cj
         VUSvBbPkWTtzIy9B3OdPN0FDM1X1hJtMJk1AUKngkaBp/S1EVZca39EuOGynXkQ+tWWL
         NX9w==
X-Gm-Message-State: APuU4Z+KojqRf40aZY2PxkwuV5Cf+uAqHRrA5zgLDJDiKfLDF69Mjv5O
	vXdjgilqbaM9bNZl1OvjMBPveAq1VWvkwQOfz7nUd2tAzs0oc9lfzc9FBN9GzCPC
X-Gm-Gg: AYBFou2268rp8vAxgM2b82y9tAZCadEF6R7CVa9+wQpcsU0kJpdlKV+q8ZaheqwBCOk
	qPA87XAdeg8t7UqdOuJ0Uurp6doDqws+hgWOH9Hyac73k8KYDvY4Ii/2krAsQ5OVyak17Phxb2n
	SE6595kqD1VDr3l6dNcU3oZsFaJOoCmyrbTnmBVM9vi0+kHT90/v/krQNtDjovgSbX0o/qJVblh
	zrNI31cL1ReNAA0Q4jQo7wnJI9mgjomUkOph0Dg9sIF7jAtV7OqXUDjpOY0pmLsoBJPGfFkFMqk
	9L8h68JDDWoDCyGKmKZC+/S61GWmxkSW3P51xVrQUO+u/KphpkSoNPnK6fcJ96GjZuREHjrm3NE
	cUcg3LnpNfAeGJiUbS9Px6334QFcXQw06RNUK3jM4ry8sQmM05NBeAHAfPdGTX7+o0fWpeMNVuV
	2Q9Y50HCRfjPQJdTGioxuqz22mBhF0svFAR2Ges4rTDesa1OfPDdswQGKEdOICYjY5FDiF4onRg
	emsWNQ4l4xjGUNlQmXtinZwmk/a2kH4spTZ1HLwqW3xAgPfPbrxs/Peg0WF+DGjHxcjuB4a4RE9
	NKtsOhsw48gpdv5C/mfSrJ1YvmZgmAODQT9wh1mKGKo2/0QcxcJcOWENcmtMlg==
X-Received: by 2002:a17:90b:1652:b0:3ac:7874:639e with SMTP id 98e67ed59e1d1-3b1b0a4fe22mr6003015a91.46.1794687598486;
        Sat, 14 Nov 2026 12:19:58 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb17853sm9892063a91.5.2026.11.14.12.19.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 12:19:57 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] AGENTS.md: add guidance for AI agents
Date: Sat, 14 Nov 2026 12:19:07 -0800
Message-ID: <20261114201912.32656-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 20:20:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5377
Content-Type: text/plain; charset="utf-8"

Bring in OpenEmbedded-Core's AGENTS.md rules (mailing list workflow,
commit messages, AI-Generated tag, human-only Signed-off-by), adapted
for yocto-patches, and add what is specific to layerindex-web: branches,
testing (including tests that prove a bug fix), migrations, the two
settings files and conf/local.conf.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---

This refers to requirements-dev.txt, which is added by Piotr Buliński's
"requirements-dev.txt: pin the development and test tools" (patchwork
104045), so it should go in after that patch.

 AGENTS.md | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 AGENTS.md

diff --git a/AGENTS.md b/AGENTS.md
new file mode 100644
index 0000000..5310566
--- /dev/null
+++ b/AGENTS.md
@@ -0,0 +1,118 @@
+# AGENTS.md — layerindex-web
+
+Guidance for AI agents working in the `layerindex-web` repository: the
+OpenEmbedded Layer Index (`layerindex/`) and the Recipe Reporting System
+(`rrs/`), a Django application.
+
+## Shared OpenEmbedded rules
+
+The rules in this section come from OpenEmbedded-Core's `AGENTS.md`
+(added in openembedded-core commit 06d397a09e, "AGENTS.md: Add file"),
+adapted only where layerindex-web differs. If they change there, update
+them here too.
+
+### Making changes
+
+- No web PR workflow. The project uses **patches on mailing lists**
+  (yocto-patches@lists.yoctoproject.org, with `[layerindex-web]` in the
+  subject) tracked via patchwork. Don't assume GitHub PR conventions apply.
+  `README.md` shows how to set up `git send-email` for this.
+- One Git commit per logical change.
+- Commit message format:
+  - Summary line prefixed with the short file path or component,
+    e.g. `layerindex/models.py: store long recipe values without truncating`
+    or `dockersetup.py: use "docker compose" when it is available`.
+    Check `git log --oneline <path>` for the prefix convention already in use.
+  - Body explains what/why/how, and how it was tested.
+  - Prefer explaining *why* a change was made over restating what's
+    already visible in the diff, unless the diff is long/hard to follow
+    or the reason for the change isn't known — in those cases, summarize
+    what changed instead.
+  - Be succinct: use as few sentences and lines as possible while still
+    covering what/why/how. Cut restatements, filler, and any detail a
+    reviewer wouldn't need (e.g. exact test-run counts, step-by-step
+    narration). One short paragraph is usually enough; only add a second
+    if a distinct point (e.g. testing) needs it.
+  - The most relevant information about the change should be presented first.
+  - Reference bugs as `[YOCTO #1234]` when applicable. Layer index and RRS
+    bugs are in the "Layer Index" and "Recipe Reporting System (RRS)"
+    products on bugzilla.yoctoproject.org.
+  - Use `Reported-by`, `Suggested-by`, `Tested-by`, `Reviewed-by`, `Cc` tags
+    where relevant.
+
+### AI-generated code
+
+- **Mandatory**: any AI-generated code/commit must add an `AI-Generated:`
+  tag line in the commit message, placed *before* `Signed-off-by` (if present),
+  naming the tool used, e.g.:
+
+  ```
+  component: Add the ability to ...
+
+  AI-Generated: Uses GitHub Copilot
+  ```
+
+- Also add a code comment or other in-patch indication that the code is
+  AI-generated (recommended, not just the commit tag).
+- **Mandatory** Do not automatically add a `Signed-off-by`. This tag must
+  always be written by the human contributor, never by the AI tool — the
+  DCO/Developer's Statement of Origin still applies in full. Don't commit
+  with `git commit -s` on the contributor's behalf.
+- Contributor is responsible for confirming the AI tool's terms don't
+  conflict with the project's open source license/IP policy, and that
+  any third-party copyrighted material in the AI output is properly
+  licensed before contributing it. See the Linux Foundation generative AI
+  guidance: https://www.linuxfoundation.org/legal/generative-ai.
+- `Co-authored-by` should be omitted in favor of the `AI-Generated` tag.
+
+When in doubt about a convention, grep `git log --oneline <path>` in the
+target repo for precedent before inventing a new style.
+
+## layerindex-web specifics
+
+### Branches
+
+- Send patches against `master`.
+- `master-next` is a staging branch for maintainers only. Don't base work
+  on it or target it unless a maintainer asks.
+- The GitHub repository is a mirror. Its CI (`.github/workflows/ci.yml`)
+  runs on pushes to `master` and `master-next` and on pull requests against
+  `master`; contributions still go to the mailing list.
+
+### Testing
+
+- Run the full suite as CI does with `docker/run-tests.sh`: it builds the
+  Docker image and runs pytest against a throwaway MariaDB.
+- Development and test tools (pytest, pytest-django, ruff) are pinned in
+  `requirements-dev.txt`. `README.devel.md` describes the dev container and
+  running the tests without Docker.
+- New code comes with tests in `tests/` that cover its behaviour.
+- A bug fix comes with a test that fails without the fix and passes with
+  it, so the test proves the fix solves the reported problem. Check this
+  by running the new test against the code before the fix.
+- Where a test isn't practical (e.g. the bug needs a real BitBake parse or
+  network access), say in the commit message how the fix was tested
+  instead.
+
+### Code layout and pitfalls
+
+- Models change through Django migrations. Generate them with
+  `python3 manage.py makemigrations`, don't write them by hand, and commit
+  each with the model change that needs it. Migrations are numbered
+  (`layerindex/migrations/00NN_*.py`, `rrs/migrations/00NN_*.py`); if a
+  series is based on another unmerged series that adds a migration, say so
+  in the cover letter.
+- There are two settings files: `settings.py` (local development) and
+  `docker/settings.py` (the Docker image). A new setting usually needs to go
+  in both.
+- `conf/local.conf` is the BitBake configuration for every recipe parse
+  done by layer index updates (`layerindex/update.py`, `update_layer.py`)
+  and by the RRS tools (`rrs/tools/`). A change there affects all of them
+  and every OE-Core revision they parse, including old ones that RRS
+  replays.
+- The update scripts check out BitBake and layer branches in the shared
+  fetch directory (`LAYER_FETCH_DIR`) before parsing. Don't assume a
+  repository there is on the branch being processed unless the code checks
+  it out.
+- Keep unrelated reformatting out of a change; `ruff.toml` preserves the
+  existing quote style.
-- 
2.56.1

