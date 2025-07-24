Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD590C87FCA
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 07:27:31 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.6921.1753342050051079708
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Jul 2025 00:27:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OeBMRQVn;
 spf=pass (domain: gmail.com, ip: 209.85.221.41, mailfrom: rybczynska@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a575a988f9so353614f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 00:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753342048; x=1753946848; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZQdw6X0kuf3VSpB1FNBw9S+gb5HiCvE/F+v3c2foR8=;
        b=OeBMRQVnJILGlF8ZL5MPeUfch4YRptiZFwoOQVeiXR1HrtEapj4oJSzmKN/sD97PP0
         rmcLRZISIvEFIohupVDWFoZkb3mabF9EeZb4Ukd2Whaj/y/b+hfpJ0yw+XJ5+re2D4z8
         bdk2nF7f2FnyEwTTobyfa6DXZI26hPtX7f0R0+/k4ny4iJ+BmSywAJaLcx4nzQGQbcFo
         G6a4yAPw5SWht5OFxgj+EvodOUzv2DuZmC8IRy4E8topIMmgRoF51nRDtvW32oWSnQaE
         NP1feoLppUTmQ93yxCcsIWnKrBwyIAwUTNFa96Lj2dGuRlK5N1MQ/WRNcPqWWroWiXxk
         iBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753342048; x=1753946848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZQdw6X0kuf3VSpB1FNBw9S+gb5HiCvE/F+v3c2foR8=;
        b=BTpxisR5VukQReDvUmb7is6sBHLYbS9QJQJ0clHgTlvXq9CHszo2v2u9FEPTfnUPSk
         YHRyOnMR6MtHzmzN3DnUPRln/OIkitLGdoR9Fx1ZSIBVdV6UGgT0BlvkZtdqrOcdXTqe
         Yb8FdN/Fmjzj94TZDdduyd66E8h6A/R56kbclvXdTRHPbjKmg9rivstFo3j4tpmUJhZq
         ApFPwKHJKhSV6XXwHc2pNGt87h5p52s6LqfgoFTcuGhkkYGi0FgL9FW1g17d7CQhoN6V
         ggOoeE5hnLMn43CMF7JJwKuxlQfx0cQmrHS2gN2YOCT7XMDKIh/t7Eub/MzGTZUl2OKE
         FZkA==
X-Gm-Message-State: AOJu0Yxn7KcsZSfTZvRXIHTm5AqLdgN+agImS+wLmtphVVf2zpV2DFbG
	EUGDEIdXaRs8CuQSFl7ZWYzM3z2djBX1FwC+l4/CZO8hHW4QWLhX25hwP0HoYg==
X-Gm-Gg: ASbGncsXRtiKbQv9mCoH0qeuUXhFu+CGYR3/ugVMmCHZ30LlEDeJgg5BLzK8T+bB60q
	/5R9dY64f4IGgHzaUJKyogIBisOE6voYnaWip6aPVY6vM4Vv1oo9v33q8SFn/QEjAJqKfERffWq
	HD3hUQ+eoML0k7U8WXcyfaHOFGDwEupWBB+KbkI7h40nx+92JIPjvGBySq7voVNWME+5SURiA2a
	rgi20bOKi2fPb4d/z33ZcXFt3D1NsGvsc74ui5UbySZDvkTJtr5AMCuzontcuoh6eNuG2m0p2nh
	tFEWkjQvOXhC+DCxbsNvGWSNGN6vXOKtxoTGf1ESa19m4Ps5HwTK+wz4fwvn3wHvAui+YOprZFk
	ISyWDOIw0X9a1kBS1J2XYS27FqYfwmccRa50=
X-Google-Smtp-Source: AGHT+IHgALhm1PTXrOBBL25WqtSQRe9BVnAEYwS76wex5qLGe7FCiXiYAc1qA3ZYoGNhwvKKILpp0Q==
X-Received: by 2002:a05:6000:2284:b0:3b6:d95:a3a4 with SMTP id ffacd0b85a97d-3b768ecf288mr4192944f8f.4.1753342047931;
        Thu, 24 Jul 2025 00:27:27 -0700 (PDT)
Received: from voyage.lan ([2a0d:3341:cd4f:d110:cf6f:2013:cd74:cf4e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm1231723f8f.44.2025.07.24.00.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 00:27:26 -0700 (PDT)
From: Marta Rybczynska <rybczynska@gmail.com>
X-Google-Original-From: Marta Rybczynska <marta.rybczynska@ygreky.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [PATCH 7/7] kas: add whitespaces around assignement
Date: Thu, 24 Jul 2025 09:25:49 +0200
Message-ID: <20250724072642.7358-8-marta.rybczynska@ygreky.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724072642.7358-1-marta.rybczynska@ygreky.com>
References: <20250724072642.7358-1-marta.rybczynska@ygreky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 07:27:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1864

Add whitespaces when assigning variables in kas cofiguration.

We were getting:
WARNING: ... has a lack of whitespace around the assignment: 'BB_NUMBER_THREADS="24"'
WARNING: ... has a lack of whitespace around the assignment: 'BB_NUMBER_PARSE_THREADS="12"'

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
---
 kas/kas-security-base.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kas/kas-security-base.yml b/kas/kas-security-base.yml
index 3ff2ae3..17f4bb3 100644
--- a/kas/kas-security-base.yml
+++ b/kas/kas-security-base.yml
@@ -36,8 +36,8 @@ local_conf_header:
     INHERIT += "buildstats buildstats-summary buildhistory"
     INHERIT += "report-error"
     IMAGE_CLASSES += "testimage"
-    BB_NUMBER_THREADS="24"
-    BB_NUMBER_PARSE_THREADS="12"
+    BB_NUMBER_THREADS = "24"
+    BB_NUMBER_PARSE_THREADS = "12"
     BB_TASK_NICE_LEVEL = '5'
     BB_TASK_NICE_LEVEL_task-testimage = '0'
     BB_TASK_IONICE_LEVEL = '2.7'
-- 
2.47.2


