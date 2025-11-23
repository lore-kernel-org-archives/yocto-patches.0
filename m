Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2BACFD343
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:33 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5034.1763941525427099924
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=oX/6XRMn;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b2dcdde65bso560146085a.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941524; x=1764546324; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLHwj9QEB00o/oUFOIqQduBjz8JP6qpNtReS9FEwPDY=;
        b=oX/6XRMnuEnPajAOEpvQxFUwQa5C3l+H3IXHD+rbplNtDdRrC447nYkBpZeVIN6GUd
         ZYCEntYOftxrBSUrArnU2s+dIAS2ARHzvt2fmw6XqoJvWSkB7/9w60AK198ocAPi5q0f
         lFHyUCUx911m25oqbm5IKZ9LpggxOD8AjBunc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941524; x=1764546324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cLHwj9QEB00o/oUFOIqQduBjz8JP6qpNtReS9FEwPDY=;
        b=SVve6iVfG4kVY2MqP5R5nC8LsT7Bd2GHgxnkkR5ezVGKOjuI0UG4RO1YkX3wh45qWy
         0Jr6MkWLigQU8psPwVPsBYBZ7f3ulzyvK1r+BcJifK8qTiwKBK5hLotp2jOtJBQ+kYBK
         KkWy50Ci6nn/26r+NqxxJpz32GglaqSUnmwiVFfqnkxOGJgu2Ui0W6X0jz7OGVvdHuHb
         UzxQOmsNL/oaO+EtYBFuvHaLP0LSvTHOT2Ay8/qvUwcxWd04RukTfcz3ZgpRYTo06Vxg
         fZqUXACzoezk1SOJ5OwdYgqev1wEYt9SqLNbKRFPJnaBe1sfdyzz2qrUpc4cP8J2Pycs
         Ua7g==
X-Gm-Message-State: AOJu0Yyu5r+PgM6I+e0k6QJhzERQ/vwvrovPKRK158Zq5vkiaJw8TUeO
	s1HxgOGhMTsGwSMErWRBx75380kaMYoGTB4+skJ0WX6CSzNefChBI+fDCCT7eeigwSgDbmiNww4
	F35np
X-Gm-Gg: ASbGnctHmKIkQ2bFR+NiAVwXbgygfI3uKMLMCJqnsEC8RI++CFze/NHvuXdFgrjDgWQ
	vHteYx1BF670AwFylkV2iKcbT2RihzNGN10EVpaCa/DYDFzclTzN6Kps4uFa8beArpgR0GRXGzL
	Y5PTaQSyf5H5qVqsBSLpvJtRJ2cys2QokJ+15t8nMcAHF9hlz+TdIfUK502RmkwzNCMcjs5indd
	tjS6KxNd114ppZ3dIeh5BsROzt1u7q2y//bSjGxvELU4NKzSCSo6XAY9SiwQr36zZ9BQZI/oM8i
	cwHKnwrI9CMAa4S1KCafFOn+leHhNruvXTtCA3DP7Z80fraRuMVd3rttgL9pn/fllHN6f0dD+Uo
	Cuok7eAnUgvh+Eh7MGzGpGwFOj8MhasqiVClWJ1umjXPsjiXq6cKmuLKYmn0dmh4wo4se0mMVu7
	sRIRli1AnViBlaNkvNW6Cv1dNefoA6m9yD2qM1xyjcF3bx91MgmVS/CnkztyFESe4=
X-Google-Smtp-Source: AGHT+IHQ1DbK31fCbXSjT8J2NPjUrtXZGtYyvIhtEKMqSfBlqFvKSFYlB1lWQsSI9DDNnvcGhYIE2w==
X-Received: by 2002:a05:620a:288e:b0:8b2:5649:25ef with SMTP id af79cd13be357-8b33d23a948mr1270591085a.21.1763941524148;
        Sun, 23 Nov 2025 15:45:24 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.23
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:23 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 08/32] bastille: prevent host uids on files
Date: Sun, 23 Nov 2025 18:44:48 -0500
Message-ID: <2617d4c9c980127f5ef5c2e905fbd125dfeb1c18.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2666

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

We get an intermittent QA error about file permissions, happening roughly
on 1 build of 10.

The change adds chown to prevent host ids on files related to the
set_required_questions.py script, to avoid long debugging for now.

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
(cherry picked from commit 7bdd0a8b48442e3a93b98647801c2ff5dee7267b)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../meta-perl/recipes-security/bastille/bastille_3.2.1.bb       | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb b/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
index f2ef335..afd7bfc 100644
--- a/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
+++ b/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
@@ -146,6 +146,8 @@ do_install () {
 
 	${THISDIR}/files/set_required_questions.py ${D}${sysconfdir}/Bastille/config ${D}${datadir}/Bastille/Questions
 
+	chown root:root -R ${D}/${datadir}/Bastille
+
 	ln -s RevertBastille ${D}${sbindir}/UndoBastille
 
     # Create /var/log/Bastille in runtime.
-- 
2.47.3


