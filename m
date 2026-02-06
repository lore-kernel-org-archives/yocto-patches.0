Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11771EE6B60
	for <webhook@archiver.kernel.org>; Fri,  6 Feb 2026 21:25:32 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1340.1770413122817687445
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Feb 2026 13:25:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=o01GCqw2;
 spf=pass (domain: konsulko.com, ip: 209.85.222.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c7146b0854so273162985a.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Feb 2026 13:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1770413121; x=1771017921; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=se5IdQcJQ+8P3BkBwYoSlpo752wa65d9zkcXwNAVZ1M=;
        b=o01GCqw2H2nmMhtDOtIcMa6CTLU65wsUKYGW3eJxRizkGYiUwLOcE0EQPrVDeofXY6
         DVWO7XTN5uiDlFUoaF4wnMB9PAeUCU+lvdkG7OwI6T2g4Lse8xRN5ZPT5b03Ri5YispD
         MSYvi+SGsjbYeAORS7Z4sGQbuDmjn248wjPAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770413121; x=1771017921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=se5IdQcJQ+8P3BkBwYoSlpo752wa65d9zkcXwNAVZ1M=;
        b=Z5oPhvKFhV1hs+/lOBUSP7cX/AD3rgEJ+FZL1x1EVNu6duzxX+/m0wwwErBSzID+F2
         6vORgH9WkV51fAOqAs1krl8dqj2LJVRNntwoNw6XsqmwsVgb1Vh0qjGik+nMXyelykMi
         aSC0AQu76xsgv7bWljAerYTXaDfk5QnZLKsCrv8CKIF2K/Lf2A7y1HgP+IY9Fp3Lspgv
         VbPAdPq4Mpw/IlmplrFolM5+xsUuBZCPi4mm+wW6yh3xRT7/KxMisjLzCV/gKAFUVDkm
         mFthJydSczXmLYG1cqRKCkSM8+mNGEUL3jatAT02b4YOcu1dBTkJawc8qeQgMI7O7+7U
         YW5A==
X-Gm-Message-State: AOJu0YxgTWKrWSY2tHVA15hsEN9lpoMuvcmMiX1+Yjm27Iiwf2ecVJ3A
	7Lgx1PZ15o4Blogm1i6GSNTxfU0YpjPCmOThIIhZOszXpwBjnJoZ42UzD/rS7VbXNuY+C5erxOU
	oA09S
X-Gm-Gg: AZuq6aJrM+oBmr8q5UTcPtuU74czkAsSKAJJguuP7p5uAXq0dVQuvJb0BPlf1uZqaFa
	Bd8niXW3UjI1VMWBp88sSexgBZWkCNf6jsW8ALvCa4Wk2exBlwhIMX9UhF+eM+MGCPCWWcegSdA
	TMiJhGVrLzsZg8A6MRv9oYeF7M+shF1ZQK5UHiQ/W/eB+tK6wQ4zLkqZ4fbONN/uvCVgprKpyyj
	gcE7/cDqeF0N5+05s1nkgXhsa5+lr4NrCyvr1R5WlxW2KowJ/F9kOLyDKW+xVt3xFKhBhKQUBQq
	kih0VO0uhBnKbh3Lb0NPbVJsbi1pvhBrrubctgv4Hda5JenEY/EO6/tV8GiUZS3bijyIelJRZj/
	/yG0GHBUGTw94tllY1/sHHZSG+DGp2cE04QIJo2FiI+vV8HxgALXE9AcGYBGo1srMyofN7AURzc
	Ua6SsE/aCRAbhbDX2fgBXwklCs2Egi2puULl1eW7DmPUQpWVD1cvpZlPMF30x7WGMyaUmbuVUVD
	Iv4hL6bZTP6HHNQAkDX8IR72LYCVBQsIcgF0yt6E55vX0txQk18
X-Received: by 2002:a05:620a:459f:b0:8ca:2baa:770 with SMTP id af79cd13be357-8caefbcb25emr584525385a.21.1770413121400;
        Fri, 06 Feb 2026 13:25:21 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf77f6f05sm241509385a.1.2026.02.06.13.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 13:25:21 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Zahir Hussain <zahir.basha@kpit.com>,
	Nitin Wankhade <nitin.wankhade333@gmail.com>,
	aszh07 <mail2szahir@gmail.com>
Subject: [meta-lts-mixins][kirkstone/rust-1.75][PATCH 0/1] Ignore Windows CVEs
Date: Fri,  6 Feb 2026 16:25:12 -0500
Message-ID: <cover.1770412335.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Feb 2026 21:25:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3197

This kept falling to the bottom of my TODO list, but I did some testing with
cve-check last week, and decided to update the patch since CVE-2024-24576 was
also showing as unpatched.  I intend to merge this to kirkstone/rust-1.75 at
end of day Monday (5 pm Eastern, Feb. 9th) if no issues are pointed out.

Note that I considered applying this to the 1.68 and 1.70 mixin branches, but
it does not seem worth the effort, as they do have other unpatched CVEs that
would require some further investigation into addressing.  I would recommend
folks using those mixin layers that are concerned about CVEs take the likely
easier path of moving to at least kirkstone/rust-1.75 instead.

Scott

Changes:

Zahir Hussain (1):
  rust-cross-canadian: Ignore Windows CVEs

 recipes-devtools/rust/rust-cross-canadian.inc | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.51.0


