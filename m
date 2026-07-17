Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD55C4451B
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 18:35:19 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3146.1784313315288021226
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 17 Jul 2026 11:35:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=FCOhs1I5;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8e5be46f663so32539226d6.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Jul 2026 11:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784313314; x=1784918114; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VMzqcjGL9EpmtqCnJw0Nnq0yygyC9qb774U+sJdkir4=;
        b=FCOhs1I5ktYqCEtamGRHvHfiVFZNRMyTi36ocix2YJN5/hjpY7qKF0seo6DDfPXScn
         gCHMrHXPeMcfz5M83sNvU2i8uxeqBYi52G+rwMrHBqYruPRFKodR32eztMTA5/06R+Ps
         Q9/b3mxkxeJaoX7rRCYaEf3aZu+kDlOQrB6jLZk8W195IXSOK2LPi2ShEJeRyvOGNEGk
         g2aDjoYxa4zEFIkCNIjKN0WlXfFBPPrNMOnZr/3FFiBcMdUVOC/AcfceDbKlmqGgN0sv
         /+vN0AGUsl2wUjxlb3dgvBC5FlSNiCldEBN6IC+pPj0YAUzSUETsmp4flNUE0/ibT82z
         q8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784313314; x=1784918114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VMzqcjGL9EpmtqCnJw0Nnq0yygyC9qb774U+sJdkir4=;
        b=BGZzkp+ZhkQLuCbLYxAFCTCktJbPWEaJUA+LPebgnraNHONA4e3Hrt2csf6ZEWCmmB
         QbdPug9wSFFqzBo4MTjaR5vyiJmBodwIzAabOlqYYxs0cAVx8X1xX9QcYpx6Brqr7V06
         gj5TcqltJj4tFn5A4L9zAkVmO/JRjyiKqj4i40xLzVGWj5O2nAQJjeSCEU2fa49mre95
         pO1CwDHk4CygADtaH3VtAP1JDG8SAqi718nubQ1G04oB28ccUgVH2jfC1AgsSE9xRvCf
         /YiLiDp1KbskJLV03jvZYPKMhECu44a14ag+22djMfgQ3OkFaH1DFCCd/pggiCyh6xqC
         LehQ==
X-Gm-Message-State: AOJu0YxAdIUOqmpLmwOBs56gs5sdCoFqDzWhldv0EYShoyYKlvTowUeJ
	zsUirGZ81cnmvF8YJo2gYPOQ72lViD5/dsqyiPGaLBE5ab0N6wIqs8HatSNACA==
X-Gm-Gg: AfdE7cmxVmMn8L3CN6br5U+bkDzmczobvFJKPSkKxYhPymEk07t6s7SeTIHU8dNat7p
	g/Tdsup89YAyMVJGfGAI5u2L7y7AbP6k368WpbxWGt8xJwRM2rUD83i7ilfrgNpRI8MGKZfK+33
	8UBGww37cWjbx+M5T591Etb8+HmUMmyCeiD2xInNcDY9LW4lgU84wJB+OqgcjyCtHZNtN1hfBSG
	QGdQdP8F/gRfEnP//PORiDjbMDnDqFwxeraxP7w+pV7UCp4u+wh6+9TxYT8Jo7nTXwGsxaBbQVE
	Q+Tq47WDgFRmdCf8zRwAzTkmpZvGki4wg5u4+18xBRH3nt6dCc03iVYNQwnVu6mwJJGEprzoAAR
	PgwWeDCsQbVSCDSk2aty46QurKP+ShYkxFPMGbSA9EkbnIVu6ZWPNRy1oFOQUEAmBeF/1qJBq7s
	6T/Rf3zGq32g90ct9rrk6nkp3G2pW+bNynAZCHnB5dki43
X-Received: by 2002:ad4:5942:0:b0:8ef:31b6:74e7 with SMTP id 6a1803df08f44-907783c95a1mr45754386d6.43.1784313314169;
        Fri, 17 Jul 2026 11:35:14 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786b21d6sm22992816d6.24.2026.07.17.11.35.13
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:35:13 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH 1/2] ksparser: fix crash on an invalid msdos --diskid
Date: Fri, 17 Jul 2026 14:35:06 -0400
Message-ID: <20260717183507.3539287-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260717183507.3539287-1-twoerner@gmail.com>
References: <20260717183507.3539287-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 17 Jul 2026 18:35:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4505

When a bootloader line sets --ptable msdos with a --diskid that is not a
32-bit integer, the error path builds its message with "... % self.ptable".
self is the KickStart instance, which has no ptable attribute, so the
interpolation raises AttributeError before the intended KickStartError is
raised. Instead of a described error naming the bad value, the user sees an
opaque traceback.

Interpolate the offending value (parsed.diskid) into the message, matching
the gpt branch just below, so a bad msdos --diskid raises a KickStartError
that names it. Fix the "--ptbale" typo in the same message while here.

AI-Generated: codex/claude-opus 4.8 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 src/wic/ksparser.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/wic/ksparser.py b/src/wic/ksparser.py
index dcf26f788083..a1276af8d3c6 100644
--- a/src/wic/ksparser.py
+++ b/src/wic/ksparser.py
@@ -322,9 +322,9 @@ class KickStart():
                                     try:
                                         self.bootloader.diskid = int(parsed.diskid, 0)
                                     except ValueError:
-                                        err = "with --ptbale msdos only 32bit integers " \
+                                        err = "with --ptable msdos only 32bit integers " \
                                               "are allowed for --diskid. %s could not " \
-                                              "be parsed" % self.ptable
+                                              "be parsed" % parsed.diskid
                                         raise KickStartError(err)
                                 else:
                                     try:
-- 
2.50.0.173.g8b6f19ccfc3a


