Return-Path: <Pascal.Weisser.ext@karlstorz.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D913FC2BD05
	for <webhook@archiver.kernel.org>; Mon, 24 Jun 2024 09:02:50 +0000 (UTC)
Received: from mx08-0040c702.pphosted.com (mx08-0040c702.pphosted.com [185.183.31.154])
 by mx.groups.io with SMTP id smtpd.web11.136090.1719219758967483068
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Jun 2024 02:02:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@karlstorz.com header.s=S-DKIM-20210427 header.b=HE+xeEq+;
 spf=pass (domain: karlstorz.com, ip: 185.183.31.154, mailfrom: pascal.weisser.ext@karlstorz.com)
Received: from pps.filterd (m0267678.ppops.net [127.0.0.1])
	by mx07-0040c702.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O5TM88013307
	for <yocto-patches@lists.yoctoproject.org>; Mon, 24 Jun 2024 09:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karlstorz.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=S-DKIM-20210427; bh=f2f9Z
	IUQvYSQcfFKUp6zUYsufRb6FKPRPgxMENLtTBc=; b=HE+xeEq+eRj6BRQapVpQZ
	0zBkVlsppantmNyCDtvpUSUlu0v5oW/9vTX965SbaOq17wJ3s+n2JLNecly5dEcz
	eyjniYSOPjaj4rSSt/osQ39JIfmG8Wh6izf9mUvL1hzzE7EPhS7X/IABnUEvjzag
	RnmtSHh8mA/JYt3h1uk2mvaxPrdm8XPjcEKXHdiz1LLCtViVcoNCqieVaHxo3Es4
	lP7nBgI5Mc9LV3wU30E4Wx3tcfoeZLAGP7wzxLEtquaUtw8cPWYCUBXH1gCWjdbG
	Slb6kjpoy1JouPq7qYjXHIank9bBEmne4EX/1w+kGHr/3iurJqsqldz0IPxbUDVr
	g==
Received: from tut-ex23-pv.kstg.corp (62-134-76-232.business.static.de.bt.net [62.134.76.232])
	by mx07-0040c702.pphosted.com (PPS) with ESMTPS id 3ywnhbnxew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 24 Jun 2024 09:02:35 +0000 (GMT)
Received: from TUT-EX20-PV.KSTG.corp (10.0.10.224) by TUT-EX23-PV.KSTG.corp
 (10.0.10.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Jun
 2024 11:02:33 +0200
Received: from TUT-EX23-PV.KSTG.corp (10.0.10.227) by TUT-EX20-PV.KSTG.corp
 (10.0.10.224) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Jun
 2024 11:02:33 +0200
Received: from tutn-bpfb5m3.kstg.corp (10.0.10.41) by
 InternalSMTPRelay.KSTG.corp (10.0.10.227) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 24 Jun 2024 11:02:33 +0200
From: "Weisser, Pascal" <pascal.weisser.ext@karlstorz.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: "Weisser, Pascal" <pascal.weisser.ext@karlstorz.com>
Subject: [meta-selinux][PATCH 0/1] Add SELinux specific configuration snippet for busybox.
Date: Mon, 24 Jun 2024 11:01:59 +0200
Message-ID: <20240624090200.1746755-1-pascal.weisser.ext@karlstorz.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: SosHLEqop8D4OSK-PhVdjzySIx8v8sSc
X-Proofpoint-ORIG-GUID: SosHLEqop8D4OSK-PhVdjzySIx8v8sSc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_07,2024-06-21_01,2024-05-17_01
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Jun 2024 09:02:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/369

This patch adds a SELinux specific configuration snippet
for busybox to enable SELinux support in busybox out of
the box. This is needed to enable SELinux specific
command line options for certain commands like ps -Z.

Weisser, Pascal (1):
  Add SELinux specific configuration snippet for busybox.

 recipes-core/busybox/busybox_selinux.inc | 6 ++++++
 recipes-core/busybox/files/selinux.cfg   | 1 +
 2 files changed, 7 insertions(+)
 create mode 100644 recipes-core/busybox/files/selinux.cfg

-- 
2.45.2


