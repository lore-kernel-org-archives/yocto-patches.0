Return-Path: <omri.sarig13@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E069C28B28
	for <webhook@archiver.kernel.org>; Wed, 12 Mar 2025 10:33:48 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web10.33630.1741775622638480384
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Mar 2025 03:33:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Hcm3q12W;
 spf=pass (domain: gmail.com, ip: 209.85.208.181, mailfrom: omri.sarig13@gmail.com)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so43559201fa.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 12 Mar 2025 03:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741775620; x=1742380420; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYokqhiuf6XaVjTzpRxsNCGZoDFaBpezR/c+jNdVSWI=;
        b=Hcm3q12WsWaSUESfXdYCWbFBbF7la9ZQHCa80AUfHCtu/J+joMvaxkodBRpSq/kIsA
         XmC/mQZfd1QUjoE9SA4/vfgZor3BcvtfBDQQSEieXLyIiq2/f75i/IjGyxdeX6y2IVd9
         oWRWc6k2rFn95/LvEElu+0HZl7woYGycF32/276/wL8NVtm9YiU9SABjfV4Eq6z6eMpK
         9C7TNZqKx4q/IRR5aPoZsbBrbowwfbs7Sr8k1CT0QcskJJQTx6nSqqNXN6mJnzSQVsKB
         vExUfuflytM6W3Eibkn3lg743upGpCGLiivu1bMGJhrKy4L/ylFdnQ3cKkzoFRgDJH+d
         K5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741775620; x=1742380420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYokqhiuf6XaVjTzpRxsNCGZoDFaBpezR/c+jNdVSWI=;
        b=CZVlpHq6+bDhFsDipuOX+l420d1bzbSPZzx2ePJXz31ydH9GnLwCMiVn1+TI0ivFMy
         GjX+P+ZtWIHvaWulAq9eMTT6PK+aHmmReyvxhTuwC37zWCNLg7MVr1Nj1pjIulJwI0DP
         Wxq9rbKvs7MI1WVsrCv9RM27B/W3axeG3+neq1Rrudp68ynlevZWzAAqLpICKcTRvPxr
         lHPzB0VibShGu7wzp7SFuOYhQl1+wan1L60Exe56FIWk3jZJf8dJtoAHoBokyVGQ4X1h
         sFXkGOA46a97aavfzeaPXOFkVUUPiFpiDaOo0V2Qq65BDgKFP0oMxxDGMrBsVbmnC9+j
         TyOA==
X-Gm-Message-State: AOJu0Yzsup/B5qGydF5zQ8Vwg3FoQtvqGX305QeY5uzIgvpRvIVCaHoU
	yJb+/o6erdXmZDtRtAzyXvRmFqlYZvB87m817HH+3kE4w2w/Wi2Tj0Nn/jWL
X-Gm-Gg: ASbGncvhL60noHfcoU/1HVAsferqs0+6Mzkb653g4RByxFycSnnODw/QHmdMglGd1Cy
	lxzr5AoZ0DSjTPjXOj3eiSQdEVwujWkSUjERLCyGTP6KJstOi/CUNJaKauxNb9L6l6gHQIUS4P3
	pz3dYQ0+EY2Ti/PxbDHrtFkFEQFBskq7S+INmyQfIfeSmGzvcGYBL95L+rFVtyIY8OGasLv56iS
	cX94c24l41UZxQIyvT8wzr2y5obHTCh9BFrnVcx0ix5O9RDGJuI1y4pJLjdzelDEeReb3qVmJ5N
	K1XAkyptaI/+aMH2zS2rqPqd68s4MxsWjQFsYZcoN4GZysmrCbkih7BD2mVkUhweLwzo7w3c4X0
	y0M0C1iT/Po33lZvMQfZbQfR2g70=
X-Google-Smtp-Source: AGHT+IFZvRk+jJqZRowRDQ35fvA2lWeIP9/hvTtgOa4Pbo/GNpwbAbE6Dt34cy1CfsSqnTrLTgiFQA==
X-Received: by 2002:a05:651c:221e:b0:30b:f274:d1ea with SMTP id 38308e7fff4ca-30bf44ed47dmr74507631fa.3.1741775620175;
        Wed, 12 Mar 2025 03:33:40 -0700 (PDT)
Received: from omsa-HP-EliteBook-840-14-inch-G9-Notebook-PC.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bfceebd49sm18030821fa.60.2025.03.12.03.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:33:39 -0700 (PDT)
From: Omri Sarig <omri.sarig13@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Omri Sarig <omri.sarig13@gmail.com>
Subject: [PATCH v2 2/3] tpm2-pkcs11: Add tools python runtime dependencies
Date: Wed, 12 Mar 2025 11:32:40 +0100
Message-ID: <20250312103241.2526274-3-omri.sarig13@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312103241.2526274-1-omri.sarig13@gmail.com>
References: <20250312103241.2526274-1-omri.sarig13@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Mar 2025 10:33:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1192

The tpm2-pkcs11-tools python module is importing several modules which
are not currently included in it's dependencies. This causes the script
invocation to fail. The current commit adds the relevant dependencies,
to ensure that the python module is always able to run.

The relevant dependencies are:
* python3-fcntl: To add the fcntl module, imported in db.py.
* python3-sqlite3: To add the sqlite3 module, imported in db.py.
* python3-tpm2-pytss: To add the tpm2_pytss module, imported in
  utils.py.
* python3-compression: To add the zipfile module, imported through
  "importlib.metadata import distribution" in tpm2_ptool.

Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
---
 meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb b/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb
index a7d8170..331dc4f 100644
--- a/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb
@@ -44,6 +44,6 @@ FILES:${PN} += "\
 INSANE_SKIP:${PN}   += "dev-so"
 
 RDEPENDS:${PN} = "p11-kit tpm2-tools "
-RDEPENDS:${PN}-tools = "python3-pyyaml python3-cryptography python3-pyasn1-modules"
+RDEPENDS:${PN}-tools = "python3-pyyaml python3-cryptography python3-pyasn1-modules python3-compression python3-fcntl python3-sqlite3 python3-tpm2-pytss"
 
 BBCLASSEXTEND = "native nativesdk"

