Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FADCDB466
	for <webhook@archiver.kernel.org>; Thu, 25 Jun 2026 08:27:26 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4983.1782364701404263753
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Jun 2026 22:18:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=CpUIiTOk;
 spf=none, err=permanent DNS error (domain: oak-lpgbuild12.wrs.com, ip: 205.220.178.238, mailfrom: prvs=0636eea621=sj10@oak-lpgbuild12.wrs.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3gfhW335686
	for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jun 2026 05:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=XsSFQrM9qDb6uls1AQzQMYYRsU1VagKDn8Go7gzGKQE=; b=
	CpUIiTOki9prMZ3yl5X1DcNzfa9eAFZczvYAmcSlkcSqCqQ2mLryXoJXXgWF0v6d
	DLONRtwap49DQVz6ez9XDsbfSEt9Q6QLJUXumwN3mlljvZ9GGflu079Il8UGC7Xe
	35e7m0CM+2P34dYcV1jYdsw+KBECADlrm2qtmaISZ9dYVk9iLmu5rSnb6GKlgOw5
	kFBAZMCjBjOJ9fONn8I+Z6lz68V0dSp/b0L7x2BdDwX/MZEhJhCujcZA5i/hee6r
	0/SeYwku+Lvok7KuvH3+Ed6gZ9bq8rP9K2ooSsmoyN8wpgOp/8+iE+MwAe5w+0I9
	AwDbOUKQXDtD5pboP7fb0w==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4f0t5dg6f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jun 2026 05:18:19 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 24 Jun 2026 22:18:16 -0700
Received: from oak-lpgbuild12.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 24 Jun 2026 22:18:16 -0700
Received: by oak-lpgbuild12.wrs.com (Postfix, from userid 1762445396)
	id B65D4390010D; Thu, 25 Jun 2026 05:18:16 +0000 (UTC)
From: "Sandeep J" <Sandeep.J@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <Shiva.Komati@windriver.com>, <Randy.MacLeod@windriver.com>,
        Sandeep J
	<Sandeep.J@windriver.com>
Subject: [meta-security][PATCH 1/1] README: fix broken URLs in meta-integrity and ccs-tools
Date: Thu, 25 Jun 2026 05:18:16 +0000
Message-ID: <20260625051816.1844262-2-Sandeep.J@windriver.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625051816.1844262-1-Sandeep.J@windriver.com>
References: <20260625051816.1844262-1-Sandeep.J@windriver.com>
MIME-Version: 1.0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA0MyBTYWx0ZWRfX/C0gwIMzKKK5
 S5WjhqjCLIuUS9eLOgTb74jjenr01E8yuHbQmuLITR/X7mnXfFUgW7NEcXdj49o6KCtJAREc/5I
 3IBL5R6qm6NtmRIOGyDfTtDI5RkhSsjEJD0cULM77TkrZcpt5LpM
X-Authority-Analysis: v=2.4 cv=HOvz0Itv c=1 sm=1 tr=0 ts=6a3cba1b cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=dnEwNotGAAAA:8 a=FP58Ms26AAAA:8 a=TSbVqHtbAAAA:8
 a=a4NEJbfMAAAA:8 a=H6WxVz_VAAAA:8 a=t7CeM3EgAAAA:8 a=I-2RzdINRxagy5z5iSgA:9
 a=QRzjZtwMIBQA:10 a=NJcUIoPEKLAEIzHnl83t:22 a=ejRDv7XJuw7nbi7PrmUL:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Ra74kviisLHFtQ3kZJ3A_tEXzXA9qGq9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA0MyBTYWx0ZWRfX+FGiJAHhvMDE
 QJZ4QzBLeLNGSc6lZO9czIutiqDerLn39vl2SWPKf+mXEJsBdgwuUgpixFpvor9NZ2X4Bc0tADO
 rtrNLzmohR6uxIjI5u2vY49qkENEbZBl0nS02TYdDjy9j4gK1+Wt40YdefeNL+CtY0REmgjCALj
 DzLboV9wLL8ptgCqFzstQvoR+hWPdygGCKSkshRSEV9GwBYeL9TeuDdVcbeN/NSM8BZYZ/ihfZy
 qRbNo6Q8YfDPk7VrEcn7HaM4tEQotB2AeNuohDJLjapxRYtvoZC3Y1s3zoY50TXEiKPzNtUEFkp
 S9Qn6n0PitZBMEXMdGIsPf6wPsAS9mxo0JUT0b1DHZQoQGWnQkGXXp3S8URw0jNkNaCM9FIQgR6
 bX837b81VUF2ghtHLZ/ONMzatCLesV5snVZsNoc9aSL9wU2zEFKCanI4J6dNq9CkFd+gmPuUX36
 70BDX19Gxa6AqUXCGSw==
X-Proofpoint-ORIG-GUID: Ra74kviisLHFtQ3kZJ3A_tEXzXA9qGq9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250043
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jun 2026 08:27:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4301

Update TOMOYO documentation URL:
   http://tomoyo.sourceforge.jp/1.8/index.html.en
to:
   https://tomoyo.sourceforge.net/1.8/index.html.en

Replace dead gmane.org permalink references with Wayback Machine
archived copies of the original Tizen dev mailing list thread:
   http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6281
to:
   https://web.archive.org/web/20191020122234/https://lists.tizen.org/pipermail/dev/2015-May/006399.html

   http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6275
to:
   https://web.archive.org/web/20210620014038/https://lists.tizen.org/pipermail/dev/2015-May/thread.html

Signed-off-by: Sandeep J <Sandeep.J@windriver.com>
---
 meta-integrity/README.md     | 4 ++--
 recipes-mac/ccs-tools/README | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/meta-integrity/README.md b/meta-integrity/README.md
index 92d24f8..9aeac60 100644
--- a/meta-integrity/README.md
+++ b/meta-integrity/README.md
@@ -270,5 +270,5 @@ No package manager is integrated with IMA/EVM. When updating packages,
 files will end up getting installed without correct IMA/EVM attributes
 and thus will not be usable when appraisal is turned on.
 
-[1] http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6281
-[2] http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6275
+[1] https://web.archive.org/web/20191020122234/https://lists.tizen.org/pipermail/dev/2015-May/006399.html
+[2] https://web.archive.org/web/20210620014038/https://lists.tizen.org/pipermail/dev/2015-May/thread.html
diff --git a/recipes-mac/ccs-tools/README b/recipes-mac/ccs-tools/README
index 0381814..dffb933 100644
--- a/recipes-mac/ccs-tools/README
+++ b/recipes-mac/ccs-tools/README
@@ -1,5 +1,5 @@
 Documentation:
-http://tomoyo.sourceforge.jp/1.8/index.html.en
+https://tomoyo.sourceforge.net/1.8/index.html.en
 
 
 To start via command line add:

