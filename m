Return-Path: <zhixiong.chi@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB24CD3436
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 13:14:59 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13399.1778246096339700909
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 08 May 2026 06:14:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Y2m3AxKg;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=95880b4bbe=zhixiong.chi@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6483iZLc1953070
	for <yocto-patches@lists.yoctoproject.org>; Fri, 8 May 2026 06:14:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=kn3DbGg2oF0KJL2WMGC5
	3wNfLGhIUxT/YT8vQ0sWSco=; b=Y2m3AxKg18ExvSBgTrsllV0wTMSVCPwfkISN
	E+3DsS2Sjw85i/HKIDR2ua/JOdCSRB1hep+BaZNHy5j5kW9jJep/mx9CGJSfUYwJ
	UuBt8iAZ2vT479xNmsF5yV5w+z0vT5TlqPKrDaiUGBTpGvtGE1WE6lFp/mcuYJBI
	G763T6WhzHvg/ukwnrJwHJRSjqnTD+3gGtuKJV60I65vC1H8FMJjkR8Q9k2X/SsW
	WKgHsAqZv8LTvHGC5WzVV7czPdyNG1DUPi/cVv30hJpVhp9TwxYxW4mmReJkY3Ad
	ev5qFqs/IdltRDku1b5MT7QdzIRqH83QawGIzIXB99/yzH42DA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010043.outbound.protection.outlook.com [40.93.198.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dwgsdfwxe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 06:14:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3pemRuh0Qdg5rOvOMqKr842DagAFoDwM0hNBfwMIrH4Mshd4WyxgG152zybIS2g1piAzBJZUr7PKLlU+CqsgOcx5eIEqeMqNlulamLkdv4dCgmkj9YZo2jPsVZZhxluQy7XnsYzKksTd/OxL/NIIBnZHO72ns4swFE0T6KV4kGOTANg3KQroN3DywrCIGFuPj6V7aBQzx3CbBPrgtVZa27LwNAEYFLmiskZB+mbsZqTqZwtxKNWGUWbVWu1J7NmewS99vSHCRU8A+qTWHjFDyKaN1u/7PN9mTeispMzCBuB3U3d8lCPAMfx/gRg7n/bJB7cnsIWDoMfUJC/ZZmeoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kn3DbGg2oF0KJL2WMGC53wNfLGhIUxT/YT8vQ0sWSco=;
 b=g4RCPINOhk7rn5XN/yxqvwDuvU6YENXtHlBvB1mFEq1F3g0qbNjliwhy3+AscX66h7M+1T5afAw3GsRXi30XrFe70nHYfuODhotriKiPCIVUGWZkRy1Z+B59v2er84vqMOdNMtFfjOMn00v2envvkt/y8p+UxsXp7luu/HE6k8jccPduatLf5juj8WOscYQJnUnF8thV3eImjj/WEppXWzGGW1xMs54OmK0fZXHClX1+A6HT6gwok3YN0Sz65zkZzGOYhhMRhyGzH8JZLtkMh98O/TIfBKFV121V4ntpPDYNtkNQLFOCxaXYvezWGGqZuyfWXS3YkNuJGclB4Xo0pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPF75D68BA1B.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::32) by PH8PR11MB6801.namprd11.prod.outlook.com
 (2603:10b6:510:1c9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 13:14:52 +0000
Received: from DS4PPF75D68BA1B.namprd11.prod.outlook.com
 ([fe80::881a:ac0:4717:712a]) by DS4PPF75D68BA1B.namprd11.prod.outlook.com
 ([fe80::881a:ac0:4717:712a%8]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 13:14:52 +0000
From: Zhixiong Chi <zhixiong.chi@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] selinux-python: remove all RECORD files
Date: Fri,  8 May 2026 06:14:46 -0700
Message-ID: <20260508131446.516411-1-zhixiong.chi@windriver.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0181.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::6) To DS4PPF75D68BA1B.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF75D68BA1B:EE_|PH8PR11MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa026f8-9b89-4290-0966-08dead03ca56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|3023799003|56012099003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: 
	UUXBVcKBL4jaXORjCzHV3OuDLwYTu+wiuyFd9CLr0QVfBJtA8kG81LYLpRhu0+swuws70bhn0b41HbSBoPj9G1xtwtwXJMQ75Bj7vVEKSQ7QP5nEeRNHy3DZ+DtkvicQC7cQf4Sg40FN6OHvcJgVp8kIwLD2u0ckA57EYDC7zM17fp40Xv3wVXajgZKWPHMrtHZTb4zLN/7boLfxvcN48vfK7LAdXxyhnGZ/2qpnI20ryCW6zCukfBnSzlLuRmIYkMycb3eKxSU3y1X68rQmm1PwI0H1rmgqcYaYwlNmSHWjchb2Ct5BOShPKQdbxT1c4S+J62wn8EtyxFkYIcrwKyod3DWIUmOXDYQmrParLpEOi0H4Olq+zveeBSVY8TyWsvhDwZ/Gm73u2p1FUCf69COirsDnC/yp/ITEVvObewtL7RqeC7iSdwbHVLF9vSAZ1SMFOy1NUQlcv0WiFyUF3AE2fChre+R2zEL0J2xcCrsrkVqJCINfrOZN3wHO0KpDcifiYf2KZdmaRKMxJZ44gggnb93tfA18yq/yXhndpK7J0JrKZoxdvqtjOtXm/QpMuW5HNFaatu+Wrs85RtH9J+TA8nmaV1XoxXkJMwot+cMbYnWOJlcm5JrUMY/WW3yfmaliDNqVfezTGHbiF4j6HRy0ydFy5jnPYNqkPk3vqggif1UTc/+CVr7CwTekfWqJ5MXNVNFxcqthAV+odcg2sQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF75D68BA1B.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(3023799003)(56012099003)(38350700014)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LK5M494RiK8ERtRxJ5S8qRQIzEC1Vn2Gp3k0ORotgQNLjPkXDgV1LQGxJg2d?=
 =?us-ascii?Q?pICSrMC+WHFaGvbHTTMezoTHCubL0iY8SwSJAPoTELR3pXSKeDhYtGXPytX/?=
 =?us-ascii?Q?B4kJ4bQwhSETgIkCZlH4UxTO7Bqe+pdvjt0CJabiHvzNZeK7MHDblJWNrbpc?=
 =?us-ascii?Q?wPYiKWzQBmyoC+Tcb81v7c1A9/muv62H89YUtUA9dmDXNWZHkzGKMkDl8X2r?=
 =?us-ascii?Q?Y/f5h3226uEP12iqJfE1TpsPlXl2wH+yZ1W9/UCtgfYTFbnRnx8kdN6SOxbt?=
 =?us-ascii?Q?jgtTAYlGWV0Ye3CADx1HElS7XUSQcUOApYIQ2T5MwwlanB5Uf+BKBQTa6crm?=
 =?us-ascii?Q?jrMIQJCVnzwetAAqeokSvNR2BXus2Hi1hVf41Ek99X7VZQeOmMzLqZGmxoRq?=
 =?us-ascii?Q?1IB8WuZ2/zGK7Y5fu3cqr+s+vI+eMBexqwaGg6+MewXXQCyCCTflVkQGcPUV?=
 =?us-ascii?Q?sj88rckM8v/bUN5DCAGzPc3h1h8s5EH3B35ATbBqGOLNYn5FHo9V7cDTh4Ri?=
 =?us-ascii?Q?H2hyuntoxMDoODioqwIJgz8sXtrWwFxMLvfZHGkxvAcRfs65kOV3tSV2XPGG?=
 =?us-ascii?Q?jRXQaHRdQx5MZ7cQl4UnuauAMWNvrLWz/0X3K317qI47InDaV6/gFjWC5pKa?=
 =?us-ascii?Q?TIo+ftPnsdjFcPjFeLhr5EoN2eRsB0uLPHZQZZwTRZMLD9d22Hj0FyVmjo6H?=
 =?us-ascii?Q?iRdmEparBBCtbLUI5oFeTDrZhv8e6puK0dAhAZ5Vf7EPY5MAXL1PU2DzVCES?=
 =?us-ascii?Q?kIR7wLKyX3ZB2qq/yt7Y90kgyytTaZftGE+640ew+l15wRb5E8Ld7n+dzcoj?=
 =?us-ascii?Q?5kKLiyFXmi4Kylg8//iAxjlqbUWxzU6O7X9EXGkhJZod8g9UmL0D0KnYfHYz?=
 =?us-ascii?Q?N/le5eligiU4BCP1ogX2ZZg0/3JxrdHFjR8tjie5RLZKKxLhWoeu4TfFyQCh?=
 =?us-ascii?Q?1Q7hvcZWncpmGQbt3nI8rBlY+oj/Y1go4KdzA0MNWfhJzKeCLh8A4gr4sIsc?=
 =?us-ascii?Q?UaVbnsWRzrLOFrXjCjXHpzgN0vdnwjajQUrZM88ca5y2Kkv6UAh1pDSOwRZ5?=
 =?us-ascii?Q?2Cf7dLdFurdBxHTMHNZcIoUwsB/X2Fwxkbaz6UNL7tc/9aNOxJImHdP03T32?=
 =?us-ascii?Q?sARMzXofw/XbAmDlO2P8fwE1RUKczxUEg9/BQGVnBSuK6KIIQQwIbE9DA+vs?=
 =?us-ascii?Q?N7Db9WnXYzyPAFLEH/6CTiV/YxTsdUYVdiv2+Sz2hsUPHkvSRlC+CVkpmhCB?=
 =?us-ascii?Q?iYp5XejDrcTBp7Ixa9m2Yhb4qVFpg/ADWLvw1z5Gvp13MYWnjxxbpYGe8hOa?=
 =?us-ascii?Q?8hByyg17lHntOne/SQINwQC9wfgz3xbxsYZDm47w9z5Q8akc44sFg3hsbLTB?=
 =?us-ascii?Q?rpBWBPLq9WZrOqDKnAg/Y8ndQqZT4coDqQoykm9d8FCGdHEw+pksfAOtj08o?=
 =?us-ascii?Q?mcYla6Vwja0jq21880aHkQ94jdyMe0D7yEOVYPAAbHnkA3rlIG5uEEWbwQmr?=
 =?us-ascii?Q?tiZ5LnE+pgEfW4Sz/lT+Xc8/fOrxpgzyzsvWYg8lpGtT+jeacolnFJrp0Bx8?=
 =?us-ascii?Q?OFow5OMX0+KSzloPaqiYN0la/sy2Vg+0miJTNB8fNoS1+0FNDKcBoXjaAY4R?=
 =?us-ascii?Q?R0EjJhdP/M9bufA8iSUjrliXR24q3HWwlpIs1ckZmxIw5vaHxThICRXM52ks?=
 =?us-ascii?Q?8IYOX11NM1HFA+P5iVCXEFr8dPVNZ5KSEchrEFCm2oyUo2KAedIx2p05tw56?=
 =?us-ascii?Q?mE37LvcXba1OjXrVc02jr3BZoNBARgI=3D?=
X-Exchange-RoutingPolicyChecked: 
	vY//yY2dZ6LgwYI4iQFKQLObqot6pFfUwSaNNeKVJmUg9bwMyJ1ooW0KiHLZWTjBTzC3M8yig7A2NpBDTHeeuXergXahZyLJV8DEA6XqcqeYqwQWUSJNwE/mP7PTG1XX9XZg6hawoJsFqkpMX42lmiYmzuqe60spgYCd/R55GbldB9JJslkx+9DYMI0o0flHRPecOEh6gyKKRdgjPU1LukxocSvwTccLSvQSl8pg9Ww3W3Gp2u4WY4IltbzC/SeMfgsHurm4gdT+DqX2Sz4UhvWugiadxrczyLFqwgb/9IGDCM97CxZpipf7WHkqyM9YWBvWjHJ8pym9Mw881WA7eg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa026f8-9b89-4290-0966-08dead03ca56
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF75D68BA1B.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 13:14:52.6339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Fh9yVFyyPZnE99uDoZzrNlDMJrL3si12dyEyHrPMEwBA534yOQ3eig1Ln/NlQxxB9BlNTTeuahejOjtH0X0RnRTrUtBP420ayw0ydxL3Ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6801
X-Proofpoint-GUID: yVcHQy1aHoJlNBWNWlJF1JkiWqzmP3yp
X-Authority-Analysis: v=2.4 cv=JeGMa0KV c=1 sm=1 tr=0 ts=69fde1cf cx=c_pps
 a=CcIcsZDwO3wB2ho3dvPJ0Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=8AHkEIZyAAAA:8
 a=xNf9USuDAAAA:8 a=vTr9H3xdAAAA:8 a=7mOBRU54AAAA:8 a=t7CeM3EgAAAA:8
 a=qxTolJBQgbHWKOguPvoA:9 a=wa9RWnbW_A1YIeRBVszw:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: yVcHQy1aHoJlNBWNWlJF1JkiWqzmP3yp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEzNyBTYWx0ZWRfX3Daa1laY6OfK
 k5TKDNncDMiOL9jPMfxfO71mWPDwIstaKEmF0I42+UU8lsxQ0c9g9ZSomJpo8SG9SJXC719zT8k
 KR01LGSrSOXoqmneyWTS52K1U+i15pLMGYVAwdS1/9top5cSjXFCj0rTvEmwNqqmVxhBKUYuYoL
 Qm+9aAsPuLToJm5i1HdQR+lb61eC/FwNk16S28Wk6CiHI6VXYETW+8doNrwZwnyHUKDADGsi8bW
 uIuW0SrcaNgOpLY8sRcdeYjmatT9iUziOobbtgc2cYTw6AcFMz60AJ0KQmGlwpQC9glccRHh13p
 ikTY10FYJf2V7AeminoINszOhz9X19QkXdsU3J7u8ICHU2ZgGmTdrp4MHAjKnM1BAwgx4vUyZ31
 HCg4BKqRMaK/HDRl5g3hivSUHNl7FHMiHuk3AhtlfIO9HKK8HmJYC7xGFy1RpyICiZUqt7Plkjt
 bQiAo0ceYmq/fk73bjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080137
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 13:14:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3952

Python modules install metadata into a .dist-info directory, one of which
is RECORD, which contains the files that were installed and their
checksum[1].  This is typically used by pip to validate the install, or
to know what files to remove when the module is uninstalled.

This is slightly problematic when we need to do patching of installed
.py files in do_install(), as the RECORD file has already been written
at that point.

However, the RECORD files only really have a use outside of a system-
managed environment, which our python packages are.  We already have
commands to verify and remove modules (opkg, dpkg, rpm) and the RECORD
file existing simply allows people to 'sudo pip' and alter the package-
managed directories outside of the package manager.

This is not a good idea, and some other distros remove the RECORD file
to stop this possibility:
- Debian[2]
- Fedora[3]
- Gentoo[4]

[1] https://peps.python.org/pep-0491/#the-dist-info-directory
[2] https://salsa.debian.org/python-team/tools/dh-python/-/blob/master/dhpython/fs.py?ref_type=heads#L185
[3] https://src.fedoraproject.org/rpms/pyproject-rpm-macros/blob/rawhide/f/macros.pyproject#_105
[4] https://gitweb.gentoo.org/repo/gentoo.git/commit/?id=73c49f3c00415dee99407dabba8d3b22895c9d25

Signed-off-by: Zhixiong Chi <zhixiong.chi@windriver.com>
---
 recipes-security/selinux/selinux-python_3.10.bb | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-security/selinux/selinux-python_3.10.bb b/recipes-security/selinux/selinux-python_3.10.bb
index 7a4b781..61abd77 100644
--- a/recipes-security/selinux/selinux-python_3.10.bb
+++ b/recipes-security/selinux/selinux-python_3.10.bb
@@ -122,8 +122,11 @@ do_install() {
 
     # Remove .pyc files
     find ${D} -name *.pyc -delete
+    # Remove RECORD file
+    find ${D} -path *.dist-info/RECORD -delete
 
     # Fix buildpaths issue
     sed -i -e 's,${WORKDIR},,g' \
         ${D}${PYTHON_SITEPACKAGES_DIR}/sepolicy-${PV}.dist-info/direct_url.json
+
 }
-- 
2.49.0


