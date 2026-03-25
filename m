Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B591093168
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 02:17:27 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13679.1774405046209001029
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Mar 2026 19:17:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=fCO/KlP+;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7544e4345f=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P2DEJt3459919
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=jd2idB5HgUrcFkdHx9PKmp0cciW7hQRIbzJXqrP5avo=; b=fCO/KlP+kjuS
	wT9D/zxKpZyhuqyECEx0qiOKavSTdy/f3SEDBCoX5AfFX2+6sDBHzUNDCALaqfsI
	SuxnC8QrGpoqfWTehqoXvzENyHOxU1ICMV5AE9tgKkLvpoa03Xj7PsynM1r8qqf2
	eYD8VcI70Z6YQH6GvKGmOc7OHxAmw/UJIdmhFTCi28eE8HD5MccclwUxbWjC3I1b
	DMlemkIMir9OI3T13nQ7HbdkPLj6edI7GspW8eW2l/AXZVr7FT+DvXb52OOf7BPR
	7A/adv+E7no8RQZSF9CS++0Tf0NM9QoQfD56AeFdJRA/COOExDiciZBHH5RDeqEt
	KuDZCfkDFQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj84du8-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:25 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 24 Mar 2026 19:17:23 -0700
Received: from pek-lpg-core5.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 24 Mar 2026 19:17:23 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-tensorflow][PATCH 3/14] classes/bazel.bbclass: multiple fixes
Date: Wed, 25 Mar 2026 10:17:08 +0800
Message-ID: <20260325021719.1526525-4-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325021719.1526525-1-hongxu.jia@windriver.com>
References: <20260325021719.1526525-1-hongxu.jia@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Yt1EadxFZPDWO-H32ep-oKk-4Mfhx7ir
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxNSBTYWx0ZWRfXy0viAqzkCpMQ
 2JSV+6xtMNL+TSHJKKT/tubGzwFDcNB8uxVtZWsgVaZKYbeft/9NvQtaaK/Xrv09dNGYkwcEeco
 EKD+JDCbQJh4qoqyncU16St3GoGBulflFfvZR5jyXyu+mN90ygX9ZJvVT/OaKQP3CbPMvocGBTn
 vuDwV1vxxk99sdPmBrfh7ef5j8dzJWGse+TiOBeUSI6wSEc8cKTsOvFd5iC9ym1Rl1/YNoghig1
 nH8aVS6YJ2lpK4Bw3y17Uw+muR2ggloZz5s0fCZwutkzHXeX9i5zSPkWY3UalUe7zBZ0zBS8meh
 Ke2MmEyA1InORi/NmIKd9qjwYP5HqZ/F6xWF3wciHw1ULzbf8Xi23D0Z0ec7rvp2h8MR81R8Zlz
 a5crC344TzgnkSCjAFSFOg0NCn56vlgwSnRRkXa/bxIcvb/B3++6uKgb7t6VvcnG2/XHO9NYyjb
 Iokg29GkgfNgG8w41rA==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c345b5 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=RRy4Ucs9MDQ5WodQXZYA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Yt1EadxFZPDWO-H32ep-oKk-4Mfhx7ir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250015
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3537

- Make run `rm -rf ${BAZEL_DIR}' could work

- Remove znoexecstack

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 classes/bazel.bbclass | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/classes/bazel.bbclass b/classes/bazel.bbclass
index f6585e0..556739f 100644
--- a/classes/bazel.bbclass
+++ b/classes/bazel.bbclass
@@ -100,9 +100,6 @@ build --spawn_strategy=standalone --genrule_strategy=standalone
 test --verbose_failures --verbose_test_summary
 test --spawn_strategy=standalone --genrule_strategy=standalone
 
-build --linkopt=-znoexecstack
-build --host_linkopt=-znoexecstack
-
 build --linkopt=-Wl,--no-as-needed
 build --host_linkopt=-Wl,--no-as-needed
 
@@ -156,6 +153,11 @@ export YOCTO_NATIVE_SYSROOT = "${BAZEL_OUTPUTBASE_DIR}/external/yocto_compiler/r
 do_rm_work[prefuncs] += "clean_bazel"
 do_clean[prefuncs] += "clean_bazel"
 clean_bazel() {
+    #  Assure to run `rm -rf ${BAZEL_DIR}' could work
+    if [ -d ${BAZEL_DIR} ]; then
+        chmod -R +w ${BAZEL_DIR}
+    fi
+
     if [ -d ${S} ]; then
         cd ${S}
         if [ -e ${BAZEL} ] && [ -e ${S}/bazelrc ]; then
@@ -165,4 +167,8 @@ clean_bazel() {
     rm ${BAZEL_DIR} -rf
 }
 
+do_compile:append() {
+    #  Assure to run `rm -rf ${BAZEL_DIR}' could work
+    chmod -R +w ${BAZEL_DIR}
+}
 do_compile[network] = "1"
-- 
2.34.1


