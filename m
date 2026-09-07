Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600F4C79FA0
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 15:06:40 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.37510.1788793595328962939
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Sep 2026 08:06:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=NnHT/jbS;
 spf=pass (domain: snapchat.com, ip: 209.85.161.50, mailfrom: ecordonnier@snapchat.com)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6b1b233ca98so2702036eaf.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 08:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1788793594; x=1789398394; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ait1EGUN1d1fS8sJq1MhaHPSWrzc+dvg6qZO9peBcT8=;
        b=NnHT/jbSjsqHFJDB8NBK7aOAYDo+l7MmIUAryzZEB2XxWOsuBkTcZhx797GTbc1Nw/
         Nhc4F5s75Kf5lsXGlDto4+cvpZUBd9NvHpRhFDgZUJHGlNgrx9jPogDTxSzN735QLuQm
         EHirSOJ1i0NVPPa1B+QPgqxL3Dh74GFgKjijM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788793594; x=1789398394;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ait1EGUN1d1fS8sJq1MhaHPSWrzc+dvg6qZO9peBcT8=;
        b=cNCcGK2/3Jek21aunuOIYcXSW/nBvmb7q7XijZ4u0XTWSaoaJ4KXKpC/MCDYV/8vUr
         3VfbdCkHr0GK9bJwuuyShQXJSySYHJSU7Wz8eyc+8GkYCsTihyYPHy5U9AdYN9+//uH/
         iSgq011Pxbv31J0VmVMIyxBSv6VtwYqeEb8fzLG9kTKkQ8nLCcoPtWoHqVDcG1Up+q/w
         A0b+hYvoHwDybD9SrkMZtquA5gfwJKtEQ6LCGwk0I9fQRPA8PQK08klPoQChNkTxf5GH
         rXxG/BtRlChBXpOqnI2wH2V54z27m2obrQQavkgQtTdmi/vygnY7d/apeCGDz4T/JuS3
         HX8g==
X-Gm-Message-State: AFuF++m1q0ZD9SIRJHix2o7YmUWgw6iot45gg4cFkieAZnBdgpUf/GWH
	cWcSYa5zYex4D5qqm11JK8j+JiD0YsmnQKa6n2ii5WxzmYn1D6giDv21p+Bh/NuLZfgqn4uz+T0
	TlZOWyAs=
X-Gm-Gg: AYBFou08wQSNq3dkWa4JjXhcQHqrlbDPDd6RRNKOI6G5lfPCbD6G25tlTFTTOXUREEo
	12IBe78OSau5hRsnN11Bb/cMGNyYi3egvJIfEFET8GHEyCgHq3IZlBK4LxM0JrjCL9J67/Ld03N
	VLGcKKfuDHn2zSOhfoIY7rVjtoPFqP0Fnm8JkSnzwj1jJGSAnrlo4HdictWglaj30RMF2/BDpu3
	mUR1L1r8xaHsGR40z/GsI3P7/hd0lkMcK0PqiTwuMAZ3OYMoMcv/CXgnMreVbMr6vqmiChSwUny
	ORkg69a3fYTiHmb99OQ+2/e8Uv+hh5Y7f+rI3WZj7g8pTwbL+gIaouecSuRRezbJiPYtOw1yWYt
	quB5dbPa+RQ/l6ouGGBTY1CCFoOujMF3h2rdOT1crfSGSFz27QAUjLJdSM7yYyG9QGzaObQPETK
	UXUHqRdXzFLfT55VHH4fD1wT90DuCZ8V8SqHq6auoj5jbRaBIKunqG/2l1/fIIqYOpNR4OShhmq
	IpgCoz8PI3y4XVzh8WvK1+v6N5WiG8pAQ==
X-Received: by 2002:a05:6820:614:b0:6ae:ab01:91a8 with SMTP id 006d021491bc7-6b6fe2ba648mr14462978eaf.34.1788793594367;
        Mon, 07 Sep 2026 08:06:34 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3356dc5c04dsm18000563eec.8.2026.09.07.08.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:06:33 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH] Add AGENTS.md for AI agent conventions
Date: Mon,  7 Sep 2026 17:06:24 +0200
Message-ID: <20260907150625.3315223-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 15:06:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4749

From: Etienne Cordonnier <ecordonnier@snap.com>

Aligned with openembedded-core AGENTS.md; mailing list details match README.

AI-Generated: Composer 2.5
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 AGENTS.md | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 AGENTS.md

diff --git a/AGENTS.md b/AGENTS.md
new file mode 100644
index 0000000..08355e2
--- /dev/null
+++ b/AGENTS.md
@@ -0,0 +1,55 @@
+# AGENTS.md — meta-darwin
+
+Guidance for AI agents working in the `meta-darwin` repository.
+
+## Making changes
+
+- No web PR workflow. The project use **patches on mailing lists**
+  (yocto-patches@lists.yoctoproject.org; use `[meta-darwin]` in the subject, see README). Don't
+  assume GitHub PR conventions apply.
+- One Git commit per logical change (e.g., one commit per recipe added/upgraded).
+- Commit message format:
+  - Summary line prefixed with the recipe name or short file path,
+    e.g. `openssl: upgrade 3.2.0 -> 3.2.1` or `classes/rootfs-postcommands: fix typo`.
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
+  - Reference bugs as `[YOCTO #1234]` when applicable.
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
+  DCO/Developer's Statement of Origin still applies in full.
+- Contributor is responsible for confirming the AI tool's terms don't
+  conflict with the project's open source license/IP policy, and that
+  any third-party copyrighted material in the AI output is properly
+  licensed before contributing it. See the Linux Foundation generative AI
+  guidance: https://www.linuxfoundation.org/legal/generative-ai.
+- `Co-authored-by` should be omitted in favor of the `AI-generated` tag.
+
+When in doubt about a convention, grep `git log --oneline <path>` in the
+target repo for precedent before inventing a new style.
-- 
2.43.0


