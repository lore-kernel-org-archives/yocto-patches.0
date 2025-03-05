Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AFBC19F32
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 10:25:32 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.10382.1741170323134046847
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Mar 2025 02:25:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cF7IyTlD;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bccfa7b89so12636655e9.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 02:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741170321; x=1741775121; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LRSdb7W6bF/3xqHfxvSaRBCkGgivdW/NtiN9hl4VFg=;
        b=cF7IyTlDWyufkmrvNPxakLQxhbIxZOq0BwyWfPdsMP1TcbWzsOUJexDGGcTCWed8Qq
         REgC/75D/m0/VhUjt9GcbYOuFgiOBGGrTcImd2P9GORzJtFrpsMeQqly9aPApFO26dB4
         jcHu2IWctTA7BAfl+ZUzW+aIeFXP0F2mnrOdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170321; x=1741775121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LRSdb7W6bF/3xqHfxvSaRBCkGgivdW/NtiN9hl4VFg=;
        b=nKwx1+emeFw9TbgpoACpe0nyuBax3001YF2vXaOOiztWUIoB7uO2tXJ7GErGeP6/Jl
         pSnL6MPi0x8Q7QBcbU2ohX0e1t51hIrS+E1sdd6ySaw5gd/aFCOxe/DFRx06TLHQmLFD
         FgSSC28V8f58AB5dK34DnAlCKri2fADMHDEwamQdxlqC23/Ln/NXkvdsQfhObdU0kHBv
         tD6Z27xDv19IA+3JQxfK2KjYednmyOu4gqZa3uMq9px7H15Sc1ddUrV50r246HO20B0U
         YeC8eVMmWg3s1TU7WAc/SzVeW7sDjIsnLdBs/S1g5wA+PWWusqcr9DpHnoPpRua83p0e
         M4tw==
X-Gm-Message-State: AOJu0YzN3NpTKHEl5Qgr2h340b9DamLJ0O51FEBmyOe4Txk4N18VpMQB
	zc1Ba430GUpaEWduLqcmhbIieKRAyB1kvyXslHYkW6OG3Q14dpUkcTnIIr0ry1a8D18xwb/IAUZ
	b
X-Gm-Gg: ASbGncs3KOgxO1jzNb8gJBUpxV3L5op7fV0TB3ZXqz+dV1/VqVwN06RlhhkF02Z7O2o
	CvvDqBeVksNr7J1vDcnzt6IYDKatLcJGcxupLeblbTbYKu145yxzsxw4fSKifybq7lTtJYPbu5o
	nsMygj/MDpjK5/66HJ2m5Z8+Fv6EWeokCZs/AISnF4qNrpr08b3eoXXmCQ8UBDX0OviRoN8ZEGn
	Js/E5c7bWeqboY4eAnIX2YZaJLclsXO3vUninFvDO5IJQ1v6fnvDjbGgyDDBcUnjgmNBswGusHY
	0CnBJcvBDO112g882sJKwfCnDFHDdHDucOagAn5uGpgcpjGf5rZWUEy4ISns4WTcQ0rJcd7Mbw=
	=
X-Google-Smtp-Source: AGHT+IEVThEUuvFP19JTldxCZ29sAHpwI9WjE9WQA2mMTLrZ/3WLm43k4U6UEIRao3Ftj6qa8m4YuA==
X-Received: by 2002:a05:600c:511c:b0:43b:c0fa:f9cd with SMTP id 5b1f17b1804b1-43bd2972e1dmr18495265e9.7.1741170321093;
        Wed, 05 Mar 2025 02:25:21 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:939e:c44d:2366:e8da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352eb1sm12973495e9.31.2025.03.05.02.25.19
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:25:20 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 11/11] scripts/run-toaster-tests: Add check of toaster fixtures against current release data
Date: Wed,  5 Mar 2025 10:25:06 +0000
Message-ID: <20250305102506.2043524-11-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250305102506.2043524-1-richard.purdie@linuxfoundation.org>
References: <20250305102506.2043524-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 10:25:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1155

Add a check of the fixture data to try and ensure we don't release with
incorrect configuration for toaster.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/run-toaster-tests | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/run-toaster-tests b/scripts/run-toaster-tests
index fbbdd51..014c714 100755
--- a/scripts/run-toaster-tests
+++ b/scripts/run-toaster-tests
@@ -31,3 +31,9 @@ source venv/bin/activate
 python3 -m pip install -r $pokydir/bitbake/toaster-requirements.txt -r $pokydir/bitbake/lib/toaster/tests/toaster-tests-requirements.txt
 
 python3 -m pytest -c $pokydir/bitbake/lib/toaster/pytest.ini $pokydir/bitbake/lib/toaster/tests/
+
+if [ -e $pokydir/bitbake/lib/toaster/orm/fixtures/check_fixtures.py ]; then
+    echo "Checking toaster fixtures"
+    cd $pokydir/bitbake/lib/toaster/orm/fixtures/
+    $pokydir/bitbake/lib/toaster/orm/fixtures/check_fixtures.py
+fi

