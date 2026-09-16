Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B71C982D3
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:30:42 +0000 (UTC)
Received: from mail-qk2-f26.google.com (mail-qk2-f26.google.com [74.125.230.218])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27087.1789597835101833176
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=s4BIoHTK;
 spf=pass (domain: konsulko.com, ip: 74.125.230.218, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f26.google.com with SMTP id af79cd13be357-93a0299c787so13618885a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597834; x=1790202634; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iwGb7IfXmzwXKCAT2zQ4MK4glKNTE+PJxtde1KfEQ8A=;
        b=s4BIoHTKuiIg/EUC8LGgpMpCd+fVVwUAieCq9DdfUzFE2tMcLhcdp5FeFavS9jSAZN
         CfIyH3PTH0WtK1PoWbeQy5XO70llMLDAZwP+JA5fdf17TJCmC4HIi8kb5c4OfGLrejK2
         4gQITtdXXbUAk/7awzcGYpH2zILXYy9egemXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597834; x=1790202634;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iwGb7IfXmzwXKCAT2zQ4MK4glKNTE+PJxtde1KfEQ8A=;
        b=pWevDxBBwYyxTUBlIOym4daxhx+4PUWpGbgg4Rw33kjM3xn8QS8/eCRKffMTa0rVcP
         oT0NMZNLCXtysd92IhSLKVHB0Szci1bZloXSLuK2ToHMrxfTZohcPlft7BNyRDq/HBQc
         RnDq/Omyi5tTbT2dBSUVuSWnqJDBJ6r+qlck2OPPDandxu/dUSBTP9+WGUGh0j8667iD
         BlrM4WxZFg0G3dtBUglYEvFeyadptlZiaNEnNTY2OJf4STbJHQrzVBSvfwucdL3Y/MI2
         FxOOiCcT4Knyjajg6dO0iYiLutRYDwqIq6gc5/jbGAvlrFyNAKhIOyccOf1J0mgueUmQ
         uKVA==
X-Gm-Message-State: AFuF++l9pwwk7Xz9X89ibTJE0vvUF9tBfwgIlvR153/MjQA74utYtV2Y
	JlCP8nDgrgDNQW7m/hHdnmxO4CCTdQN4HYWXI0fM0VXLYZbJlvvVt4H64fwmupA1J3zPNw3iP3+
	QZP/2
X-Gm-Gg: AYBFou14m2X3pn6WfXrpJa4O6XaCCKPKZhUDM6qNAlDiIeK9AXAo/ncEEZvXtWysZox
	3LRJbLOyrL3PDrIwo55qayBPahx1JGOV9PuAErconVcRl37iJTrqjEVMH1ACX0VqVdIrYwsqMqX
	QzY8zm0rxwxTzcKwA+jxx+QI67KxecAqCOgJrno4QKmAQH8JjrvmsHME7LkpaYY75lTuJv3MIaB
	iieBgJFIMweMejTYKw0XA/LegdCJsr8H4HYiP6yqiNsNceko4WzuXzT8evM5Nhm349fJ/VkpoIP
	fxy216d3DEWuiv7hdujAReAUWI0gPFxrNjoMJHPhNY/02hbIGeZ9Ksp/3EHuVu0f410xFa/yyLc
	wl9xk65zsU12KXAIchynuY7DG9zkzfAQzn/0t0uxOgkJqiZThX2Pz4gecaawEFOaluvhe6SjUQf
	+kSJQnrnhH5Ihpu0+2eHy7MmjE16bv8UQSIdpetdYEBdJopusDWEdXDPbHd1sXomBBUk+MWdAtk
	BHHT7WI3FTeR/z35ZG20zHiygPZmqIIsrExvSC0FqLpgI/7auTI6J1i4ov510Xag75Lp0o75oxi
	yEm8d8rinfgHoWaWFLLKBI0A3xbdvnakplY=
X-Received: by 2002:a05:620a:4591:b0:939:74ab:c1b7 with SMTP id af79cd13be357-93bb772cd76mr803473885a.23.1789597833952;
        Wed, 16 Sep 2026 15:30:33 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.32
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:32 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 04/24] dm-verity: remove unused variable
Date: Wed, 16 Sep 2026 18:29:58 -0400
Message-ID: <da1114978f9c9f8db2cab3febea374107a011096.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789597604.git.scott.murray@konsulko.com>
References: <cover.1789597604.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:30:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4880

From: Gaël PORTAY <gael.portay+rtone@gmail.com>

This removes unused variable that was dropped by commit d80cd2ba6a
("dm-verity: Set the IMAGE_FSTYPES correctly when dm-verity is
enabled").

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/dm-verity-img.bbclass | 1 -
 1 file changed, 1 deletion(-)

diff --git a/classes/dm-verity-img.bbclass b/classes/dm-verity-img.bbclass
index 48557e9..619cda8 100644
--- a/classes/dm-verity-img.bbclass
+++ b/classes/dm-verity-img.bbclass
@@ -202,7 +202,6 @@ IMAGE_FSTYPES += "${@get_verity_fstypes(d)}"
 python __anonymous() {
     verity_image = d.getVar('DM_VERITY_IMAGE')
     verity_type = d.getVar('DM_VERITY_IMAGE_TYPE')
-    verity_hash = d.getVar('DM_VERITY_SEPARATE_HASH')
     image_fstypes = d.getVar('IMAGE_FSTYPES')
     pn = d.getVar('PN')
 
-- 
2.55.0


