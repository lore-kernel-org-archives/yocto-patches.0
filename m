Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E52C3600E
	for <webhook@archiver.kernel.org>; Thu, 27 Mar 2025 11:38:59 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.47889.1743075536720347571
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Mar 2025 04:38:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5181479d3f=changqing.li@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R6beqV013705
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Mar 2025 04:38:56 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hrg45r2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Mar 2025 04:38:56 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 27 Mar 2025 04:38:55 -0700
Received: from pek-lpg-core6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 27 Mar 2025 04:38:54 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-security][PATCH 1/2] python3-xmldiff: upgrade 2.6.3 -> 2.7.0
Date: Thu, 27 Mar 2025 19:38:53 +0800
Message-ID: <20250327113854.1393190-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=HZwUTjE8 c=1 sm=1 tr=0 ts=67e538d0 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=CckQENj0AAAA:8 a=t7CeM3EgAAAA:8 a=h02PUzYeu0cjrVFLC1IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 9-WJYieKIEJt7srlC8fCXgiZDuAOBK00
X-Proofpoint-ORIG-GUID: 9-WJYieKIEJt7srlC8fCXgiZDuAOBK00
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1011 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503270080
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 52R6beqV013705
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Mar 2025 11:38:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1264

From: Changqing Li <changqing.li@windriver.com>

Changes:
2.7.0 (2024-05-13)
    * Changed the comparison to make accurate and standard more accurate,=
 although fast gets less accurate as a result.
    * Changed usage of deprecated pkg_resources package to importlib.meta=
data.
    * A use_replace flag was added to the XMLFormatter by Thomas Pfitzing=
er. It changes text replacement from delete and insert tags to a replace =
tag. It=E2=80=99s not currently accessaible thtough the CLI, the question=
 is it is better to add a new formatter name, or an option to pass in for=
matter flags.
        - Added option to XMLFormatter to use replace tags
        - in _make_diff_tags after diffing, neighboring delete/insert dif=
fs are joined to a replace tag
        - the deleted text is added as an attribute (=E2=80=9Cold-text=E2=
=80=9D)
        - the inserted text is the element=E2=80=99s text

Refer:
https://pypi.org/project/xmldiff/2.7.0/

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 ...python3-xmldiff_2.6.3.bb =3D> python3-xmldiff_2.7.0.bb} | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)
 rename dynamic-layers/meta-python/recipes-devtools/python/{python3-xmldi=
ff_2.6.3.bb =3D> python3-xmldiff_2.7.0.bb} (57%)

diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3-x=
mldiff_2.6.3.bb b/dynamic-layers/meta-python/recipes-devtools/python/pyth=
on3-xmldiff_2.7.0.bb
similarity index 57%
rename from dynamic-layers/meta-python/recipes-devtools/python/python3-xm=
ldiff_2.6.3.bb
rename to dynamic-layers/meta-python/recipes-devtools/python/python3-xmld=
iff_2.7.0.bb
index 811cf36..9d38065 100644
--- a/dynamic-layers/meta-python/recipes-devtools/python/python3-xmldiff_=
2.6.3.bb
+++ b/dynamic-layers/meta-python/recipes-devtools/python/python3-xmldiff_=
2.7.0.bb
@@ -2,7 +2,7 @@ DESCRIPTION=3D"Creates diffs of XML files"
 LICENSE =3D "MIT"
 LIC_FILES_CHKSUM =3D "file://LICENSE.txt;md5=3D0d0e9e3949e163c3edd1e097b=
8b0ed62"
=20
-SRC_URI[sha256sum] =3D "19b030b3fa37d1f0b5c5ad9ada9059884c3bf2c751c5dd8f=
1eb4ed49cfe3fc60"
+SRC_URI[sha256sum] =3D "c0910b1f800366dd7ec62923e5d06e8b06a1bd9120569a1c=
27f4f2446b9c68a2"
=20
 PYPI_PACKAGE =3D "xmldiff"
=20
@@ -11,3 +11,10 @@ inherit pypi python_setuptools_build_meta
 DEPENDS +=3D " \
     python3-setuptools-scm-native \
 "
+
+RDEPENDS:${PN} +=3D " \
+    python3-json \
+    python3-email \
+    python3-lxml \
+    python3-difflib \
+"
--=20
2.34.1


