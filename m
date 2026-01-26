Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA867C88E7B
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 08:53:25 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16113.1769417600435425481
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 00:53:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=y22Hf3mt;
 spf=pass (domain: smile.fr, ip: 209.85.128.42, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso35507045e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 00:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1769417598; x=1770022398; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jcgwGy/DnIIQkLJf4MiCSQMaUDbZBGg2MgShgf6Mgew=;
        b=y22Hf3mtUDIDslnBc/qtEWXB1fyK31LZIs63p2AWhc1hzKoZBCEbUqgs6lSck2P67Y
         TMx596amMW1MBJne5SLRZ3s70z1tBItM5sw3pGeOHgHsoWenU9hyrKLOrSuViRuLNTFZ
         fFfVqV3qiTgqLE9HTNvUNf82INf5cZmC28K7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769417598; x=1770022398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcgwGy/DnIIQkLJf4MiCSQMaUDbZBGg2MgShgf6Mgew=;
        b=SY5u0+YVYn2TZRnXTjEzG0vXY2ndxmtjkQvnbBxLhmQMEqJCA0CXa0j+ONlEGMwYx2
         Aae08sYugIpaAAdBcTtb9AZ9owVc9iT6NrMhabsE1lWg6c10tqbEbxespmRJsAyV9MgV
         tgekBITCJsPO/39hdHi3xdl6d1BGxBQ+TTtBwKoX2e8iA0fn69UyBhoY+WmQkmPSKKeN
         865rbfHroXXF32+S8SK8azRs9QwZmbFg31dpS5OF/m6SvyUAl6b264vGGn65Gjll0Okr
         QNDc/pLP0GiAQzsD5CSEPo36H0Otb97V5XGvv1BxRfm82SjfVs1K+T4XTDJGI/cdvYR0
         ALvA==
X-Gm-Message-State: AOJu0YzwJGvHvwiyLWQVN1XHltCGOYAD1qfJyPDQ17qFct78hVttdCFx
	RBkYow8ILIvGVO5GpHe/xc5zzcCJwosGkGszYPeYTvD3VaOFzFKWd9tcko+MM6662VqPEi6cFi6
	c3YlJ
X-Gm-Gg: AZuq6aK4FilhUlzAFaNlZV411NR85Tuupm7tqdE2f/d9JQGNFmFL60mHERVY8g5ONvJ
	fOi5dHMLvKZxENUm0qNXk87pQN6JVSOQX0N/bSGNvFJ6UZzLtfoBFbreAWTmNfTjB4SONa1jclx
	s4ZsvXbyC9aBRvNmm8i94O2+x2RAgy2MXfw1EwMU9G1fGywRXumyc1a5yVyeHUeGkJxTar/kw3H
	fhfxhXFjW+xnr2i0gTN9QR2CQqDDPm0W0WDKfU1OKxuhMv8VTYntTZtEvNFRoZ2BloAml1qVKLg
	Fe6KkDBnIVP+dF2zLNLgluCjxZiVme/qnAGiHwWliPDdUd0pGn6FxTY6zy7zYKV0UNXo1AniHDl
	13ufbcdu5FxLq+8opYSZYc1WCxxddaTqJxqzkERONI1k+9e4WpS1pV76UIehf0fliCWwooqSy62
	GhdaEiSTBsU9TqGgHwdGUTz90khh7RunZrN1LV9tkhjcRvfuGaIV1xafAZsHxmSsrBRexvP35V9
	EjIi+2EGhAeoYQd5n52mg==
X-Received: by 2002:a05:600c:4e50:b0:47e:e051:79ee with SMTP id 5b1f17b1804b1-4805cd08fb5mr65616355e9.3.1769417598509;
        Mon, 26 Jan 2026 00:53:18 -0800 (PST)
Received: from FRSMI25-LASER.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d84588fsm261871855e9.2.2026.01.26.00.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 00:53:18 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][PATCH] send_qa_email: add git-describe output if possible
Date: Mon, 26 Jan 2026 09:52:53 +0100
Message-ID: <20260126085252.178615-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 08:53:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3077

From: Yoann Congal <yoann.congal@smile.fr>

This would allow to quickly identify commits that are not on the right
branch.

Partial example of output on my whinlatter-nut branch:
  bitbake: 74f8a927ca6a20342072e5579182aea917b6dc30 (yocto-5.3-3-g74f8a927c)
  meta-yocto: 6973ca663aaa9c3ab517ee960ab7985a5bf54c07 (yocto-5.3-1-g6973ca6)
  openembedded-core: b4e7819b99d9c1a8995eba87e6f466fd8c77e14a (yocto-5.3-73-gb4e7819b99)
(It shows that every commits are correctly after yocto-5.3)

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 scripts/send_qa_email.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/send_qa_email.py b/scripts/send_qa_email.py
index e3de4b5..8d24af5 100755
--- a/scripts/send_qa_email.py
+++ b/scripts/send_qa_email.py
@@ -265,6 +265,15 @@ def send_qa_email():
         # Need the finalised revisions (not 'HEAD')
         targetrepodir = "%s/%s" % (repodir, repo)
         revision = subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=targetrepodir).decode('utf-8').strip()
+
+        # Add git describe output if possible
+        try:
+            description = subprocess.check_output(["git", "describe", "--match", "yocto-*", "HEAD"],
+                                                  cwd=targetrepodir, stderr=subprocess.DEVNULL).decode('utf-8').strip()
+            revision += " (%s)" % description
+        except subprocess.CalledProcessError:
+            pass # ignore any error
+
         buildhashes += "%s: %s\n" % (repo, revision)
 
     web_root = utils.getconfig('WEBPUBLISH_DIR', ourconfig)

