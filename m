Return-Path: <changqing.li@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27895C25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 05:40:31 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.21328.1716788421507809551
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 26 May 2024 22:40:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=5877813c0a=changqing.li@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44R4QuD4017181
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 05:40:20 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yb6y5hh58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 05:40:20 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 22:40:19 -0700
Received: from pek-lpg-core2.wrs.com (128.224.153.41) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Sun, 26 May 2024 22:40:18 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-cloud-services][PATCH] nss-pam-ldapd: WORKDIR -> UNPACKDIR transition
Date: Mon, 27 May 2024 13:40:18 +0800
Message-ID: <20240527054018.3182501-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: g8BZLe4K8kSxZl1O0TvYbfnouhzI5tSU
X-Proofpoint-GUID: g8BZLe4K8kSxZl1O0TvYbfnouhzI5tSU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=839 bulkscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2405270044
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 05:40:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/208

From: Changqing Li <changqing.li@windriver.com>

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 recipes-support/nss-pam-ldapd/nss-pam-ldapd_0.9.12.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-support/nss-pam-ldapd/nss-pam-ldapd_0.9.12.bb b/recipes-support/nss-pam-ldapd/nss-pam-ldapd_0.9.12.bb
index 7f3b9e38..582f7592 100644
--- a/recipes-support/nss-pam-ldapd/nss-pam-ldapd_0.9.12.bb
+++ b/recipes-support/nss-pam-ldapd/nss-pam-ldapd_0.9.12.bb
@@ -43,14 +43,14 @@ FILES:${PN}-dbg += "${base_libdir}/security/.debug"
 LDAP_DN ?= "dc=my-domain,dc=com"
 
 do_install:append() {
-	install -D -m 0755 ${WORKDIR}/nslcd.init ${D}${sysconfdir}/init.d/nslcd
+	install -D -m 0755 ${UNPACKDIR}/nslcd.init ${D}${sysconfdir}/init.d/nslcd
 
 	sed -i -e 's/^uid nslcd/# uid nslcd/;' ${D}${sysconfdir}/nslcd.conf
 	sed -i -e 's/^gid nslcd/# gid nslcd/;' ${D}${sysconfdir}/nslcd.conf
 	sed -i -e 's/^base dc=example,dc=com/base ${LDAP_DN}/;' ${D}${sysconfdir}/nslcd.conf
 
 	install -d ${D}${systemd_unitdir}/system
-	install -m 0644 ${WORKDIR}/nslcd.service ${D}${systemd_unitdir}/system
+	install -m 0644 ${UNPACKDIR}/nslcd.service ${D}${systemd_unitdir}/system
 }
 
 inherit update-rc.d systemd
-- 
2.25.1


