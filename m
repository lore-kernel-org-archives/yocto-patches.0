Return-Path: <omri.sarig13@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BE3C35FF1
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 10:34:30 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web10.5564.1741689261888662721
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Mar 2025 03:34:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=drdNGqNL;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: omri.sarig13@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5497590ffbbso6045889e87.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Mar 2025 03:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741689260; x=1742294060; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QC4KiBOiRjsARrYMmoeNsh1SYyyKNTAEJHoulJ9AfbE=;
        b=drdNGqNL+QKNeQleX5q0cqVlztYGj1Ry4Dz4xpeBqoljg8rqqKBQm05CEGLAg+p8KK
         qiIwXpFX29/+N8Nd5FF4JkubXuzztZr/k3dhAl9C6e4obON3burOgUMi1B9K/SqZMODs
         EmvnoReZ0j85El2m88OFmPKY4xQo+lQYjgDMLr64Dcu1UxdDamsjUtBKYw2lalGoNdGP
         QaT6OUoRPr3XRDQciT9/+UOHoOnddKQXIwGiT+NZ2IA6CM3ttSwHEYM+Hnj/68RHimxy
         QL6m38nI1z3Bmy3ydFn16Ltyvrnh7Po0z1MkxY4zWuRwhX1oJzjAEeroTm5peNCEyCFY
         c3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741689260; x=1742294060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QC4KiBOiRjsARrYMmoeNsh1SYyyKNTAEJHoulJ9AfbE=;
        b=T4fNKQ82VV+Ldt5bzTcLVEtCx70LiNKivSiCd8VvBYZzKD8kjCkqgGr3HQKqBSrtF6
         hGLkLrwUkhMWrEnzE98bisRgmam4iFrRiYWwYvElyzZCzt3s4yE48RO0Sg/WVNiVMgEL
         94BoygXW/vDojIUHnGBHCOKTlOM70rDq5lfmdkRcyqt7uxn7S1rdS4wN2U5KDftrZaW0
         t9UNLqV4riY8md4xRZr/UleEj3j4RJ4lsoPJkY/Vl5+8sXQAhMV3AfiBtEWFaPw19XuQ
         crQN3OOkf65yCSZdNJTW6XbPfVuaMxaduJS9bkosggIkvpifbiyzjhUWVYv6iB5l4syj
         /xOw==
X-Gm-Message-State: AOJu0YxUBawRJRK8mkfXeL648HOZaVT76bgwq1FQKPv+yMVfeMcelkKa
	RhyNGnGierafUHN4ELZaToCF/eExwBZ6aumKMFcWDr9HsH0gwuzIt8q0xAP3
X-Gm-Gg: ASbGncszvhr0P3wnN6rDddz5pLHkvnGZfX7qPdo7kZoeii7EZbhfLGO4fIi04G8W/7/
	GA3AQ8O2MzbrmVdk6AK/eW2nvhuXX8WDucRpJ623KxmAsJgpmFdc///9RCmq5KNpjGEdNg6s8T/
	g8WNRDNigsmpHL+VvTBZTTU/iTHgs7vOZ3PxM60tORRfVeP+VAJPJK2p4hRG3IKvG2l7BM9qtpR
	hgCF48KaLKFTQ8FORzvfE/J8wED/kG2k1Z4EfDwRZpug14fVWd2aCjDv7xGe1NcCcy7VrAMy9EO
	TeojDZZYylxthC22mf9u651iDr3x2yr0kfeoUxisJABN5NIbVfjZEo2sI+hnbyWG61wyrN4nfPC
	dBoagBqoq2yZ7AvQ+PB2Eh4qkWLc=
X-Google-Smtp-Source: AGHT+IE0BUapI6Sq2vya/N6GQm10oRVE5ty2z81m8qNHtBr6YMKpy2may/mwMiJVc6OzyH0JM0p1jQ==
X-Received: by 2002:a05:6512:759:b0:549:66d8:a1d2 with SMTP id 2adb3069b0e04-54990e5d95amr5244317e87.19.1741689259548;
        Tue, 11 Mar 2025 03:34:19 -0700 (PDT)
Received: from omsa-HP-EliteBook-840-14-inch-G9-Notebook-PC.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c0ed155f0sm9080431fa.28.2025.03.11.03.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 03:34:19 -0700 (PDT)
From: Omri Sarig <omri.sarig13@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Omri Sarig <omri.sarig13@gmail.com>
Subject: [PATCH 1/2] tpm2-pytss: Add python3-asn1crypto runtime dependency
Date: Tue, 11 Mar 2025 11:33:32 +0100
Message-ID: <20250311103333.2972573-2-omri.sarig13@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311103333.2972573-1-omri.sarig13@gmail.com>
References: <20250311103333.2972573-1-omri.sarig13@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Mar 2025 10:34:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1178

The tpm2-pytss module is importing the module asn1crypto in tsskey.py,
however, the current bitbake recipe is not including this python package
as runtime dependency. This causes the module invocation to fail at the
moment.

The commit adds this dependency to the bitbake recipe, to make the
recipe self contained.

Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
---
 meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb b/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
index 57e284b..4ddf287 100644
--- a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
@@ -18,4 +18,4 @@ DEPENDS = " \
     tpm2-tss \
 "
 
-RDEPENDS:${PN} = "libtss2"
+RDEPENDS:${PN} = "libtss2 python3-asn1crypto"

