Return-Path: <Jiaying.Song.CN@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90852C38150
	for <webhook@archiver.kernel.org>; Wed, 10 Jul 2024 05:56:37 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.7567.1720590991698865414
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Jul 2024 22:56:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7921d6a311=jiaying.song.cn@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A3qXsM002105
	for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jul 2024 05:56:31 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 406u4x3gsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jul 2024 05:56:30 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 22:56:29 -0700
Received: from pek-lpg-core3.wrs.com (128.224.153.232) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 22:56:28 -0700
From: <jiaying.song.cn@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [scarthgap][master][meta-xilinx-core][PATCH] boot-jtag.py: Remove unused 'yaml' import
Date: Wed, 10 Jul 2024 13:56:27 +0800
Message-ID: <20240710055627.2917807-1-jiaying.song.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: YVmpwKIb8EfbRfbIXYy_4avhhbeLgKda
X-Proofpoint-GUID: YVmpwKIb8EfbRfbIXYy_4avhhbeLgKda
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0 mlxlogscore=893
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2407100044
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 46A3qXsM002105
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jul 2024 05:56:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/417

From: Jiaying Song <jiaying.song.cn@windriver.com>

Due to the 'yaml' was not actually used in bootjtag.py and the following
error was reported during construction, the 'import yaml' statement will
be deleted.

Error log=EF=BC=9A
File "/layers/meta-xilinx/meta-xilinx-core/lib/devtool/boot-jtag.py", lin=
e 14, in <module>\n    import yaml\nModuleNotFoundError: No module named =
\'yaml\'\n')

Signed-off-by: Jiaying Song <jiaying.song.cn@windriver.com>
---
 meta-xilinx-core/lib/devtool/boot-jtag.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/meta-xilinx-core/lib/devtool/boot-jtag.py b/meta-xilinx-core=
/lib/devtool/boot-jtag.py
index 53d70262..51eb0dd4 100644
--- a/meta-xilinx-core/lib/devtool/boot-jtag.py
+++ b/meta-xilinx-core/lib/devtool/boot-jtag.py
@@ -11,7 +11,6 @@ import os
 import logging
 import argparse
 from devtool import setup_tinfoil, parse_recipe, DevtoolError
-import yaml
 import sys
 import glob
=20
--=20
2.34.1


