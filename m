Return-Path: <Sandeep.J@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BB3C43458
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 06:08:48 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2595.1783490918278639276
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Jul 2026 23:08:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=AMueNQgn;
 spf=none, err=permanent DNS error (domain: oak-lpgbuild12.wrs.com, ip: 205.220.166.238, mailfrom: prvs=1649ea5409=sj10@oak-lpgbuild12.wrs.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66845VdS3103212
	for <yocto-patches@lists.yoctoproject.org>; Tue, 7 Jul 2026 23:08:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=K9J0/ufJmis3J4+iiaHKEAEjcMmyl7++H25Um2I0w9U=; b=
	AMueNQgnrMvK9T+iPQK3Q3zUyrw2MruhQ4cvFJfEC/QRl7b11/D/qiCMEzHIby1N
	7yAF9BuCQVe1H48ivCVq/miyO61bPKdnJvPlEQ8GvgL0bbPn0oQh1uGz01g4HXuT
	1ccggKDoKhTCKcU8gcwtbYKuPPtGObI8ROrcqEPXDVLqYpslqc4KsgOeFCHRiVSJ
	DzpkuSGEJIDD05frzYzNzI8VZ6kzpI/3f9m7URjvI4uFG29ORx0fpoULFbN3qsUt
	SU7UXGcBlvlh5ijyZiAirl56w+OmS+NvmerCSKPchViyd+RSQ8T8UWqrn9VqOLkc
	7XqMwPF53dJfPk2ZwMmqEg==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4f6wf1dg65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 07 Jul 2026 23:08:37 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 7 Jul 2026 23:08:37 -0700
Received: from oak-lpgbuild12.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 7 Jul 2026 23:08:37 -0700
Received: by oak-lpgbuild12.wrs.com (Postfix, from userid 1762445396)
	id 01107390015E; Wed,  8 Jul 2026 06:08:36 +0000 (UTC)
From: Sandeep J <Sandeep.J@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <Randy.MacLeod@windriver.com>, <Shiva.Komati@windriver.com>,
        Sandeep J
	<Sandeep.J@windriver.com>
Subject: [meta-security][PATCH v2] README: fix broken URLs in meta-integrity and ccs-tools
Date: Wed, 8 Jul 2026 06:08:36 +0000
Message-ID: <20260708060836.1340817-1-Sandeep.J@windriver.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625051816.1844262-1-Sandeep.J@windriver.com>
References: <20260625051816.1844262-1-Sandeep.J@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1NiBTYWx0ZWRfX82LmPBgI2r66
 aq5eHaEF4vUMCW/VkjH9kHvHAHg71SIOg54iUWADY9LqP/ELZ0aBu2t5O5zXSKkrjZQ9oCKXiiF
 kdQI6eSWucv0av8oHxLzbMawykJkZlPIgZo0GY+W7QjhvX7qogQ2EqWaqhN38lqaqm3+n9071y7
 9IsUJjMDTmjywGHijMlNx4+D5WRGgRnS182j7h6i555ZLoxG1vtuNoJ60DA48sdmnTdyXFT34SC
 Ptr/OhwsGa70nTNMykdU0O9YNAO25myffnbko2iA6SCSOD3fYlobAxYbbnUWSaUlf+PWtKRzrn7
 tSrbjXofCXpZk8N6kCpm1WvsY7zhwdXhF1UjDdQuq+CGyH0BLqhd/83LgwzSQ/65HwrzixTxeNQ
 96pO1bSXgQ6oxxW4Rr0Esi1RA+xtW2a5R7pNajSEZn0SS/IV3+1hiRTUDEysb+WBxSFtm04dY/b
 u4uW9WJl5bZb7GssqsA==
X-Proofpoint-ORIG-GUID: Q07rriDfJl68mu8wDlNibyPMGCr_Z7p8
X-Proofpoint-GUID: Q07rriDfJl68mu8wDlNibyPMGCr_Z7p8
X-Authority-Analysis: v=2.4 cv=cuarVV4i c=1 sm=1 tr=0 ts=6a4de965 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=dnEwNotGAAAA:8 a=FP58Ms26AAAA:8 a=TSbVqHtbAAAA:8
 a=Vt2AcnKqAAAA:8 a=H6WxVz_VAAAA:8 a=t7CeM3EgAAAA:8 a=dgC49jBuqLpX9ECS-N4A:9
 a=QRzjZtwMIBQA:10 a=NJcUIoPEKLAEIzHnl83t:22 a=v10HlyRyNeVhbzM4Lqgd:22
 a=ejRDv7XJuw7nbi7PrmUL:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1NiBTYWx0ZWRfX6RIzxoqV+hYa
 2bhO0VCozm78i03SsiKp8bCCSB4x4BOXtC+uOYbEoVPgyLT40M+1MJh72VCuTZt9L1kN9kU4hAd
 Tlz7Zmk2Q+WYCQwFRgUYjABQ6cBvk0LbXBCje6B6/6rucMMPV+yn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080056
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 Jul 2026 06:08:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4451

Update TOMOYO documentation URL:
   http://tomoyo.sourceforge.jp/1.8/index.html.en
to:
   https://tomoyo.sourceforge.net/1.8/index.html.en

Replace dead gmane.org permalink references with mail-archive.com
copies of the original Tizen dev mailing list messages:
   http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6281
to:
   https://www.mail-archive.com/dev@lists.tizen.org/msg06106.html

   http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6275
to:
   https://www.mail-archive.com/dev@lists.tizen.org/msg06100.html

Signed-off-by: Sandeep J <Sandeep.J@windriver.com>
---
 meta-integrity/README.md     | 4 ++--
 recipes-mac/ccs-tools/README | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/meta-integrity/README.md b/meta-integrity/README.md
index 92d24f8..9dcd518 100644
--- a/meta-integrity/README.md
+++ b/meta-integrity/README.md
@@ -270,5 +270,5 @@ No package manager is integrated with IMA/EVM. When updating packages,
 files will end up getting installed without correct IMA/EVM attributes
 and thus will not be usable when appraisal is turned on.
 
-[1] http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6281
-[2] http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6275
+[1] https://www.mail-archive.com/dev@lists.tizen.org/msg06106.html
+[2] https://www.mail-archive.com/dev@lists.tizen.org/msg06100.html
diff --git a/recipes-mac/ccs-tools/README b/recipes-mac/ccs-tools/README
index 0381814..dffb933 100644
--- a/recipes-mac/ccs-tools/README
+++ b/recipes-mac/ccs-tools/README
@@ -1,5 +1,5 @@
 Documentation:
-http://tomoyo.sourceforge.jp/1.8/index.html.en
+https://tomoyo.sourceforge.net/1.8/index.html.en
 
 
 To start via command line add:

