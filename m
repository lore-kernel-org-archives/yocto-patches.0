Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0251BCCD19F
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 21:22:35 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web11.1669.1760649753997653038
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 14:22:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=GZfDlc86;
 spf=pass (domain: konsulko.com, ip: 209.85.219.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-87bb66dd224so16559936d6.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 14:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1760649753; x=1761254553; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEXDtiTp4A6grxVHqrP1RDRvJ+2ek1PN/BgfrD64mqE=;
        b=GZfDlc86Fred1zZCa8Zpu9q4FM1UEZj1EsllhFlEUqbS2vRLwo0Mn6rLPJRghNMTOY
         xCwMA5pE4hwQ/5jZU73FrNharHtAKV8DHsRVZCEWBeYrJfkkr4/P03XE3Y2PCFVrub9G
         S9Vd7Ltlq7JrQLlofn1FW8ZaoASYSJpz4DCyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760649753; x=1761254553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEXDtiTp4A6grxVHqrP1RDRvJ+2ek1PN/BgfrD64mqE=;
        b=kIQam2rlehOFiiNJ1VNLsrxe8rhiuQFV9axBn1JTqYgeufpYByclOq+XbGU1RVgWX5
         ebIGbrX21Xxzb1cjX2Upmug6u1hK34tpPnpzTewz5ks3KX1szG+h2ss7w+Yvb6fmG1GF
         uKUpymwc++QusXpfPj6tZX0+HXL10abq4S3riikel7ipgJG23PotXZdeREpBhM7nRc1v
         ULQU6VQBuGYpQK1TfvGXUiQBfr/84hu5yR2ynFJSx4iNLKfdRxXPjEIeSNDl2fAE85hD
         qq01l4WlZTH7QF/IgHvmSbILtVMco8YNcRtuhKm1zfyo9rZhJQ3/xQIiwKy0emtqYmhH
         WN0g==
X-Gm-Message-State: AOJu0YzkGEES9dfHA0S+xwu0TGZt4S0sxVbUk0P5cpG/7haxZ4MZfpod
	xjfI/nlYSvUo+rK7oGe19clVIgwSpD3b1RWxYP4zt3CPJBWNKBOl4F5mKTUXKbLyWtqSiQwM6yz
	IEOp2
X-Gm-Gg: ASbGncvFEsQ8wSB0lnHR1n6ruATzt6L1pcfDbyufY/oqA7MI/p1gGn3ZksS2MrFExY6
	Mq0wdCmeitOsmDnKbWHEqOeLpFsdw4Fx7MvYgghbjY0skvxp+vPdPC0xu0vO1BoexdxoayOj+qS
	GgitDgWlXtjHekko7ibdMt/cbUd730UiNz6lldVH0rwxlXifE5m8RjXiBqrJWufcJvIPXmV1XJr
	fNHaBgVHbopRIHBs5Dmcm4diJ4TDJ7hIvA8Z6rgH98fQS+oy9X1flz111LW6AKjGjvZYF9rqM0V
	qpk4Vpazx+K7KWbxRBgSzyH7y0QdeK/KXrrooyBrLVLYquitr35Ja/f0L0EaBNeDU7sR3OFsqPX
	gmx4re2gKqt6Ihx+8/ooZjKX5u1AFeFy5AGpzyN8R2cBVb7tt3ONUCQ0ob8QalzJfI94LrDB6jR
	Qo+Tdpl9FfEtYGtTnQ1WWmlZLeGu8GYtQBj3ye1slkjs1ynw4QfvcwFL+GOHgARJY=
X-Google-Smtp-Source: AGHT+IGeP3i+CX0sKck4OtDDe9jKc3vETvfQP2vgoZCvAsFE7pxUROrgn8nYszLsVv0WOb+g1NWp4Q==
X-Received: by 2002:a05:622a:134a:b0:4e8:955b:ac22 with SMTP id d75a77b69052e-4e89d29a9c7mr23152651cf.31.1760649752577;
        Thu, 16 Oct 2025 14:22:32 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c1c2fd4f4sm14647466d6.7.2025.10.16.14.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:22:32 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH 01/15] kas: use repo name
Date: Thu, 16 Oct 2025 17:22:00 -0400
Message-ID: <6cbe841e8b09ac4804e8c87e23f81d68f97c17f4.1760648348.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760648348.git.scott.murray@konsulko.com>
References: <cover.1760648348.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 21:22:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2326

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

Use the repo name directly, otherwise the build can get the wrong clone.

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
---
 kas/kas-security-base.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas/kas-security-base.yml b/kas/kas-security-base.yml
index 17f4bb3..e5af7bc 100644
--- a/kas/kas-security-base.yml
+++ b/kas/kas-security-base.yml
@@ -6,7 +6,7 @@ distro: poky
 repos:
   meta-security:
     layers:
-      ../meta-security:
+      ../meta-security-staging:
       meta-tpm:
       meta-integrity:
       meta-hardening:
-- 
2.51.0


