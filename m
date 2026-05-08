Return-Path: <zhixiong.chi@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D521FCD3436
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 13:17:09 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13399.1778246228151286797
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 08 May 2026 06:17:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Z4sEaFq7;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=95880b4bbe=zhixiong.chi@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6485fRxu1596691
	for <yocto-patches@lists.yoctoproject.org>; Fri, 8 May 2026 06:17:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=kn3DbGg2oF0KJL2WMGC5
	3wNfLGhIUxT/YT8vQ0sWSco=; b=Z4sEaFq79DBrbKTDhiahh5izsCbGIlKGg/vB
	INzMTrPhsxHm2PLBnLLZTOOfpDMEYRAAqfnOZQ/Wp2u+BGnOAOpeOSjJ9gWBtVx2
	+tRIWpkmjVKRqm3FMJ7IKslaHcKueP/8wNH8Si6e1u0DvBh+p8Prkladk7sQjgiE
	vPe5RMqXaSzsHT8W4CsGMLUIvDDNiWMhbBGq/7+leQpQIqpV8DIdnrOgVcLRM5wI
	YhXsPMF9U+qMQMXBRYXTYLz5iJjZk2PTQx1aCMaifyrCUufnPjG3EP9P8Tk1dvXU
	nRw2afpM2kTe8AZUmSWFlxDfOUStFjtR0N9uHv2aiV+ri7X1WQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dwcj000qt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 06:17:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsNAQFvtj+iyOr6Z3Yml8hzMiJBcVxfWLX4B62G7RCq4EekfidF+SIV7KN7BmbpLgFKoBHIrQKHoZUXi+lZFFHAOnld0yuvCf/V9PeiJJkKcSQtELgfji1uXTEZ+2ayBWGV0rs7zRchz3TfVx06/riTBKzqd2HUkCXPdYL6cnLdO6IDmHroaeu308FgSG13aeqawKHgUO7SU80Y28qZymC2o2y6eShtkhjW5hOmNRuTM+8mNgOm8xcpei4I2yCFAZGXjKq3d9nIMHIszi411GGPGsZdigMC+xg+c1ltl08slxYHzEmR04npqQaBf8oqrMKZTifOq8MThASv2deGzmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kn3DbGg2oF0KJL2WMGC53wNfLGhIUxT/YT8vQ0sWSco=;
 b=N76hjh+wp0GhvKLKvkwCQFSzNvLilPureXIKsNaEZfqRM5wP6wmPP6+rI6eTcE/pULAJjl6IMjSH7IqZZwd/77rCvoDCRzWUOLXfuQZqRLczwevKUW8/KJ5QSr73/rZ+CP1rE4hZpLf4bhEXHjZHSJf+X8lOdw8ugtmOZC8+lcNAryH2jC+iwi3kF0NDmREuQTy+S9NaOObp6E7gJmVu7syZh6BWNQuIBg/bvzt1CacNkc8KJNGk6MvobJmwRNQp0mlfn43WdfAUmuNiR/i+nPsujFSKGSkayKO7FfsPbNAFIXG2r9kQLIflP0LVn52z8T2Cq0hNaEAhl0rD1ywDgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPF75D68BA1B.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::32) by PH8PR11MB7965.namprd11.prod.outlook.com
 (2603:10b6:510:25c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 13:17:04 +0000
Received: from DS4PPF75D68BA1B.namprd11.prod.outlook.com
 ([fe80::881a:ac0:4717:712a]) by DS4PPF75D68BA1B.namprd11.prod.outlook.com
 ([fe80::881a:ac0:4717:712a%8]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 13:17:04 +0000
From: Zhixiong Chi <zhixiong.chi@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][wrynose][PATCH] selinux-python: remove all RECORD files
Date: Fri,  8 May 2026 06:16:57 -0700
Message-ID: <20260508131657.516463-1-zhixiong.chi@windriver.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::31) To DS4PPF75D68BA1B.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF75D68BA1B:EE_|PH8PR11MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a487c16-1eab-419d-b731-08dead04189e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: 
	tbTGdh1Uhs1O+8AahsHYkcQ3LvwstuioYapsJ/yq9h2z3/U3dDdSMeJXapp8UgN0pX91Q4udl64zk573vgv2thw11+iFU6uGnlVMxxpL0fZ1GpHYokyi+FTDNdvA7EZjgUMx3TsqCnJFI1LQabyrRIUpXM6vdXV8wbBA7Q1HIbomyqkSIbJArRHE1J1Vc+JRTCU1R9LjPeZwVV8T/jaoKnBpmApX09V29vnYMLwiXt3L81OW3sz0V4qEYtKs6LfdSwQtJ2jaUFB42kpY2nC9jw0DxjDHRNjpCzo3Ljm8uvzAqwbS/xmYsuUo1ZK19qha8cDMTdHGmpKvb6nC8HbpcrxHJ5hphq1upC2rhEiMF3lYiNmSjHAAP59AkPGO+xxMNnNxX3V9dDH2WiXPlvdUe7BIw9GEkU9pWqMLcwbtrVUy5DR7Kxhg6G/EIvi9Z4Rx4ogBkRgBw/vmhFD3NFuwxZPNYGNRuxtmMzrsXEbO64t9cwFAaTcJom6JEKVnD4/e6I/K0PO2AVJg2mXoxUQYpa/zBeiFuwJ3hs+89uOOvkFH0n1mGM4Dq7gCNKzm/Q/e5kt3br9oQBoCNdDrQdGcsEKQYB0hatO/kDs4lURta9f4INLVTE0GCj4HNn/R2EMFeIwDK8iaUjfKGneJhxFeJYI3/Euh/mARQN8x47ADawM5FETNvMJHW9OGx+2JXucysg/mIwLYHqVYCRhUBpyPJw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF75D68BA1B.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(56012099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pHexiqLPkhsjsrAuWPJHJ8Fl/w3/ZGxn263P0q3M3FaomB4fu4xp6dpTvAHI?=
 =?us-ascii?Q?dGO7qer0FmGcz87Ej+qZ+TubVgdUGR0qoSsBK1G7IUYMr52bG4YWsMFbvO9j?=
 =?us-ascii?Q?nxHZtDsHIDmbXHeGhx3HHMQw2tiVb1PKuazCwv59A4l2C8g/Ux+pNBCK2YTd?=
 =?us-ascii?Q?lipSxpokKuHXyB5gwFkFFc5/gSYxkRRn2GTZxSJ77kFpB6ZzCVuc8/zpT2rz?=
 =?us-ascii?Q?fFgUO7ur8aNqbUqOQR65tQwzzp+ocC8VTgFavGYpHuipyC9Qg3T0vB2XDmXW?=
 =?us-ascii?Q?lJxEzcnBcI2kBsUULqQErbu/ZQEsAevegstPCF30SZckEewwS1LSvZcc0aV3?=
 =?us-ascii?Q?0AdTmyONpdROl+xcWuTSQt1umv2DLS/28VsbX3/fxdayD6KSWyMZDy0UeotG?=
 =?us-ascii?Q?95xdz9z+e4YFuSpj+4j51G3jYtXKkwc/BuegyFiLLns3dzkeEyvRR8ebGRnf?=
 =?us-ascii?Q?pVec9XpDKvGIEhm2nfEzQkTZfUVNrjCU3MZYN/m4RoKRNDeDAUNYNlswQL78?=
 =?us-ascii?Q?b+0k7ve86OvWgRdWQS+yAwuZLSJEvM823j6U4H3eSlUepw9Wx/VWUJhu/Wte?=
 =?us-ascii?Q?tH1WWt97VBZvGpW6wfb4bLibbqHx8BudpeA3UZRgSKTbieiYo8QU4CfKtI58?=
 =?us-ascii?Q?7aNxXbbFfok5vR/UilsIMoWJTV+fUUBO2GeufNcuSPtVpwolaC34NEZYudIc?=
 =?us-ascii?Q?G+TjYWlUfL9bkqEyvqmh5C+BrVmyqCXLkpTHup+pa0xDr7svIYGThw4yxdLw?=
 =?us-ascii?Q?h1ODaj2Sz4nor8dGVkw6QuvUsiGIPmEebayjwEdq3HeSRdTcxYo4VLVfrBvl?=
 =?us-ascii?Q?NHTvd0zA9ivn5HcBG/W0V2NU1CpI2QKAOOnhW4nr/T8ZvqG+zWXrIAAKWMVI?=
 =?us-ascii?Q?KMYZH+/7AyfUHOmWm2a0RwHa2NrZZ206kAZmX0+LzgXElQWEOo11ND0IuU7H?=
 =?us-ascii?Q?teZXiNB3z3FUwCCCf4YgtDYd9LC+LpRsk4yFRbFqHs9EpM8KvIesCClHqTSg?=
 =?us-ascii?Q?9GYAO7dPEuTKSu1ITvYjxmct+DYGkEmUuSXJrcbUCZsCXnoKIp5TPEVNoWRg?=
 =?us-ascii?Q?mmE2ApYD1yJ8e4DQZIpAcaLaQLgJXAIvvrrChlWg2gdrBtlpLCV7bgWnZZSo?=
 =?us-ascii?Q?3SMClIYoUbpr6NLHD+tPJF1KAMOaupBIjE9BHZbRf8fOoPYJencGiL04hNAE?=
 =?us-ascii?Q?xruKfDolEHyBCKaqBQK7/PhJE+HFBX2nR8vdluDLN0zCbRNGjKTIOR9ynSsk?=
 =?us-ascii?Q?W7Mddm6O71Y72kS5qpm+4iuMCWdjf673qjfXQguLKHVTLoW6SoYU4yhVJ0h0?=
 =?us-ascii?Q?xcMa9Zz+2pwxRSZwVlNydlsIdJnG+PjeENXN0zyrv9xXQrnvG1G87k+O3uOi?=
 =?us-ascii?Q?6hcwFeHEa+xqedT4f2losVTI6DoZWJm0jg3unWpOV0YW8eNpxl2Lx1rkptTO?=
 =?us-ascii?Q?DM59jxa4xjmfcP/m8jPshxF2Fd7FQsyxzE5/lhdDG0N55+8Vojobdyebm26L?=
 =?us-ascii?Q?qOcLJkH/xY+PzAIqCT6UlzBbnWtF9424IX9lcc9I1vw7anMSIMlJrMx0Q0CL?=
 =?us-ascii?Q?yq8BUAgC8S4Mmljfb17YlHoAeZv7msmo1Aatrz+pfag6dboQecQdeaxQRfSY?=
 =?us-ascii?Q?C7B5wGTpyrttLvJ8KWgPL+tIN7jkO3jbSHYNcC/3k0RWm9rZyxffShtvaWV6?=
 =?us-ascii?Q?5KjtIPmL3JCZF9GVGNUi4/8MLHv+5y42u6gZ2olDWXI8RU5aJy6FeY0wPnm2?=
 =?us-ascii?Q?nKetFIhg5RWoidvLTIsfOL2Kak3GdTg=3D?=
X-Exchange-RoutingPolicyChecked: 
	umpQ3EUnaGmwwdIhOTeSDbSY0sv5Jn4MJVZq9rUYNj138sTvfEw3OWmadkCPINnJRbse/m8wbs/eLH2KbJd6InmtYISRMWpi3fw3/0h/HENWSs9/BlC8B8A4PpRAGg5F+0QJAJBohy5VuBp4oBDfkmLBxSMRJI3AWQyLiaplz6qghN8tFOamFnAoOzMKzaPesrXdkNr9cBL01DA4IKrD3yTaDFtzcGZuAhmUpkbvlXzsidUaRUci/bXQpZwJlHTbTqUfSTVuuTtvJVQn16RwguCUDvL05HP6WpWWtNLvmeOcpJu1ig4oppYJqfKGCG3QHaDpOE6+pm9PY3Wi+2bEOw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a487c16-1eab-419d-b731-08dead04189e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF75D68BA1B.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 13:17:03.9052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jr6go3RVnGiI2sFxgzm8iIHevXB0fEeVAgET1soo3lSeYcNrW33kMWKz1EDwhjRQ516ZD75q2/QWSCfXUipWiuXaVXJP5tEm0bXeyeh+O7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7965
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEzOCBTYWx0ZWRfX/7nbp6b2wdnl
 T6vROvAZqGUBN5c2XLgWBAfvrLhEfwNrw6glpmKlgm7wu5ZbvfphdmXwvmzdmdBfwL3BhoPrpb0
 dS3mzYsXa3BMLPRvGq548nNuwe22+mh0mEwWVoO/jZTquu6GyeQZiBAkGBsObKP3mkEzIzNUrP2
 PrlauELVqUlg+FwSHCOTWT8e+TEczp7i/4+fF4GBX89Gcb6KePaUSi/S22FT5XYjzScQexaNVlj
 a+4qgRPcVfV3oM6aQakR40Z7a5Fq5KYe46ErxbfEQc4J8MsngvibTVwgSuZH9l7Tl3nVcEcuTqf
 s2a5rFo2hJdooIK1H0+7uRtXjrVIPBK1ZVu5Vhvl9v2mL5CtaR+mfunzBlosMq2JMB3cESuoQJr
 ku1SE2oJoo+D3m3704TZMIic4l4200Kuz5S96q1uanRadoQbwxV1QJrKgzQO2xZJnyjcv3SXbU/
 6stY0NqUreL8kv4mw8g==
X-Proofpoint-ORIG-GUID: WBtXS9tivAi1gpiIXziXCPOwEl3ZKfhb
X-Authority-Analysis: v=2.4 cv=LsSiDHdc c=1 sm=1 tr=0 ts=69fde253 cx=c_pps
 a=NooIwpZNnZK4GOBrdp331w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=8AHkEIZyAAAA:8
 a=xNf9USuDAAAA:8 a=vTr9H3xdAAAA:8 a=7mOBRU54AAAA:8 a=t7CeM3EgAAAA:8
 a=qxTolJBQgbHWKOguPvoA:9 a=wa9RWnbW_A1YIeRBVszw:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: WBtXS9tivAi1gpiIXziXCPOwEl3ZKfhb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080138
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 13:17:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3953

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


