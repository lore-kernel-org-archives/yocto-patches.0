Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.554.1794413716570793426
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Nov 2026 08:15:16 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6ABGFDdp2529923
	for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 10:15:16 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][pseudo-1.9]PATCH 10/10] AGENTS.md: Add to assist future developers
Date: Wed, 11 Nov 2026 10:15:12 -0600
Message-Id: <1794413712-18072-11-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794413712-18072-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794413712-18072-1-git-send-email-mark.hatle@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by gate.crashing.org id 6ABGFDdp2529923
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 16:15:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5308

From: Mark Hatle <mark.hatle@amd.com>

Based partially off of the Yocto Project standards, this is my attempt
at documenting the configuration I use with agents during maintainer
and development activities.

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
(cherry picked from commit fe4e4f0d920d587f0ded3c044255ee27269d2646)
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 AGENTS.md | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 85 insertions(+)
 create mode 100644 AGENTS.md

diff --git a/AGENTS.md b/AGENTS.md
new file mode 100644
index 0000000..c0d041a
--- /dev/null
+++ b/AGENTS.md
@@ -0,0 +1,85 @@
+# AGENTS.md =E2=80=94 pseudo
+
+Guidance for AI agents working in the `pseudo` repository.
+
+## Making changes
+
+- No web PR workflow. The project uses **patches on mailing lists**
+  (yocto-patches@lists.yoctoproject.org). Don't assume GitHub PR
+  conventions apply. Subject on the mailing list must include
+  '[pseudo]'.
+- One Git commit per logical change (e.g., one commit per fix, refactor =
or new test).
+- Split unrelated changes, even small ones found along the way: a bug
+  noticed during a refactor gets its own commit.
+- Keep every commit building cleanly, with tests passing, so the series
+  bisects.  Put a new test after the fix it checks.
+- Commit message format:
+  - Summary line prefixed with the component or short file path,
+    e.g. `pseudo_util: Remove stale with_libpseudo() comment`.
+    Check `git log --oneline <path>` for the prefix convention already i=
n use.
+  - Body explains what/why/how, and how it was tested.
+  - Prefer explaining *why* a change was made over restating what's
+    already visible in the diff, unless the diff is long/hard to follow
+    or the reason for the change isn't known =E2=80=94 in those cases, s=
ummarize
+    what changed instead.
+  - Be succinct: use as few sentences and lines as possible while still
+    covering what/why/how. Cut restatements, filler, and any detail a
+    reviewer wouldn't need (e.g. exact test-run counts, step-by-step
+    narration). One short paragraph is usually enough; only add a second
+    if a distinct point (e.g. testing) needs it.
+  - The most relevant information about the change should be presented f=
irst.
+  - Reference bugs as `[YOCTO #1234]` when applicable.
+  - Use `Reported-by`, `Suggested-by`, `Tested-by`, `Reviewed-by`, `Cc` =
tags
+    where relevant.
+
+### AI-generated code
+
+- **Mandatory**: any AI-generated code/commit must add an `AI-Generated:=
`
+  tag line in the commit message, placed *before* `Signed-off-by` (if pr=
esent),
+  naming the tool used, e.g.:
+
+  ```
+  component: Add the ability to ...
+
+  AI-Generated: Uses GitHub Copilot
+  ```
+
+- **Mandatory** Do not automatically add a `Signed-off-by`. This tag mus=
t
+  always be written by the human contributor, never by the AI tool =E2=80=
=94 the
+  DCO/Developer's Statement of Origin still applies in full.
+- Contributor is responsible for confirming the AI tool's terms don't
+  conflict with the project's open source license/IP policy, and that
+  any third-party copyrighted material in the AI output is properly
+  licensed before contributing it. See the Linux Foundation generative A=
I
+  guidance: https://www.linuxfoundation.org/legal/generative-ai.
+- `Co-authored-by` should be omitted in favor of the `AI-Generated` tag.
+  Don't add other tool-specific trailers either (e.g. `Copilot-Session`).
+
+## Building and testing
+
+- Configure and build: `./configure --prefix=3D$(pwd)/test && make`
+- Full test suite: `make test-verbose` (or `make test`).  Single tests:
+  `./run_tests.sh -v test-name`.
+- Tests are `test/test-*.sh`, with optional `test/test-*.c` programs tha=
t
+  the Makefile builds automatically.  A script exits 0 to pass and 255 t=
o
+  report a skip; C helpers conventionally exit 77 for "not supported"
+  (for example ENOSYS), which the script maps to 255.  Create temporary
+  trees below $PWD so pseudo tracks them.
+- Changes to the server, locking or path handling: also run the
+  test-parallel-* tests several times, as they are timing dependent.
+
+## Code layout
+
+- Wrappers are generated by `makewrappers` from `ports/*/wrapfuncs.in`,
+  `templates/` and the guts in `ports/*/guts/`.  Don't edit the generate=
d
+  files (pseudo_wrapfuncs.*, pseudo_wrapper_table.c, pseudo_ports.h,
+  port_wrappers.c).
+- Linux is the only port.  Put port-specific definitions in
+  `ports/<port>/portdefs.h`.  Where shared code needs something only one
+  port provides, fail with `#error` for other ports rather than silently
+  falling back.
+- Keep pseudo.1 and README.security in step with behaviour changes:
+  options, environment variables, diagnostics, security model.
+
+When in doubt about a convention, grep `git log --oneline <path>` in the
+target repo for precedent before inventing a new style.
--=20
1.8.3.1

