Return-Path: <zhixiong.chi@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155DBCD3447
	for <webhook@archiver.kernel.org>; Sat,  9 May 2026 05:18:20 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6746.1778303893892365821
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 08 May 2026 22:18:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=glebi8G4;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=95892e51f6=zhixiong.chi@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6494wF9H220146
	for <yocto-patches@lists.yoctoproject.org>; Sat, 9 May 2026 05:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=kn3DbGg2oF0KJL2WMGC5
	3wNfLGhIUxT/YT8vQ0sWSco=; b=glebi8G4jmWBbAIUGpvuiCjd0g+Zs55poPsY
	xM6ZgqJELaL7JJhhPnTlNY6UBGt+V8ItprcaWpbrpdphGar7+Hof58lvmvHff3iu
	vbKvhDxNJysnpY5zfw5ZD188c82SYMzWG2LcmmdkGm7XkCE/l7aKf3v5A+AfSOpi
	aJ04PcE9R9A2398pCGtur/Vvh0eo+AZhiIDdxM4diilOLUoF4g1ppMjLiIhhqXUf
	tAmK3ssxpWfZT7J4gN3muzqfKIyPgrZNRi8OIbKeyZ8br4xyfzIaVTkWDTTkDJqX
	BY1mVth51EZBL7cYn8IKKjO9kvLyLY8b59Mw4wNBRQEfQ6YV3w==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e1t50067f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sat, 09 May 2026 05:18:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPLX5529B2SQKe5Q16DYfo8usuGX1CxgE/A9pVNxXFTNYLgHWNVh3mWbkF+9XCcDF7HWR+v60W6F6XCa1PYVbDgTEllAhK8veMtocapzzp7BfA1E2gITtEl0PNLFN21hwVsc9SBtT/HlLCSRTcbpAWhYJU0GuzQx6NkliUhnLo9w4BjWHTcBe5JpFswbwndL6GdMIfQcomDz9UYjnQ6S59kz7PFE3kSwNTP5LA+XAl3ekrkb+sxnrNXojBcyKI8YV6rHa3T/vJbSu38yb4hWLglyfZwLOtEzQveBgamE0yh3Yx1siEO6JMuOFeActfoGn+iF/aRpNfn2Nrk8pr5T/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kn3DbGg2oF0KJL2WMGC53wNfLGhIUxT/YT8vQ0sWSco=;
 b=CalY+3M6EZr6ZaiBpHb98WfpuRCMJoqpU2lsFiQ2RuCs8Hzxw35Y4+9loQNQlPe1KvoFEPo8ID8CxXU6OW/4lHO/4NtkuZ6HMl4nQvd5eDvIpkPUcbmXH3b6hqIhpjkXxIDMMUcG0qeWOceadUZrnv46PoXhSASQvswHL5Ox8mR84OhPoBm+vufVU/sbM7SrbT3x2BEmxFkBNTCS2v1mJxNBLkovtRrS7IFbm+psVBkuovm/yu+AY/WvvNxlweeKUpUBKV8NMAQ33vJqFTHeZqOWyR7H9Th39/mk7H0mlBZkfEQhJr0NoGmKpJ1uM2rt8Yi6rOFTlalqcvLpqMIhpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPF75D68BA1B.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::32) by IA1PR11MB7677.namprd11.prod.outlook.com
 (2603:10b6:208:3fd::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 05:18:06 +0000
Received: from DS4PPF75D68BA1B.namprd11.prod.outlook.com
 ([fe80::881a:ac0:4717:712a]) by DS4PPF75D68BA1B.namprd11.prod.outlook.com
 ([fe80::881a:ac0:4717:712a%8]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 05:18:06 +0000
From: Zhixiong Chi <zhixiong.chi@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [v2][meta-selinux][PATCH 1/2] selinux-python: remove all RECORD files
Date: Fri,  8 May 2026 22:17:59 -0700
Message-ID: <20260509051800.243345-1-zhixiong.chi@windriver.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:254::12) To DS4PPF75D68BA1B.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF75D68BA1B:EE_|IA1PR11MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: c5482abe-649c-44d8-b010-08dead8a5a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: 
	Q8u+yZ0Hs8P24FEbyRf1UdnL449YxVFukD6xV8sxUzHIFRChcb4n/PSDML1TalG7JFjJ6auyPAITbOMPuoHAynNQvafRaq6mrlomCsH6PFbZa/Qm5LeTl+CXarFeB9BywoLxmeFTXSJeujWVWQjdfvxxlA7S9qbvCWqSFNLoFv+1ny5PY8iIfCXe4lhlz5u6ZvXGe+0pmj4MWBSIJovRnfVAe490Wx1XtlmccEptW7pMu+Aw+9fMeR3pCe8EXJ3c8OFVE+o1f4JWvFtg+S13/R9USrG1RFGrrc/IJuK2/4btl3uhR+ecxfL9kVv4pw0N7Hd6y12EGP+Q2BufMQvwmpm5HyJ4HHC04uebayh5bupvtif5XJGsilZuBA5piYLeDe71LuOEr48uhEtRNe6Idoxn2ALfNqC4ps1bp4g6MjobAs7286oXpbPxBaHvFP6HFvBQCuRk6iLG1kksW3yQHAH4fi6PodjyY8sPy4NkLTAWfBLJZSp4LswpRDu+T0vkNEouyulbvqTZB/T1JNMgcrheG6S/+7ukGecAZqMt3Nkx1BVIqTvx7TaxHQSU8UukuN6xCb0LjkPTnYDHDoaVICOdheF+KURerXl2oqdD3rgrZu+CnzXf5JPz+s1GE93mv/48sKIG/ugTx+M2KqsfZsLMXzCQ3H1vNO7NAeUX1/uuN6e4JU+pp8xV17W56b0gA5YzHXnAbKe2fIG0uqqkrQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF75D68BA1B.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6DObuQ7012gB/JkJ8tMInaJtzWICXCKRDAdLLUWQXxTK6bXR1YUYi1qEC/iD?=
 =?us-ascii?Q?T9z5bdQXBDxtZ3UhGpjXKgjWSEYNnJ+eYMsTZ/x1i14vbh3kaB7S/kEtFqmM?=
 =?us-ascii?Q?ePOBDqyzcfZVadF2Y3crIfiMpmjeQAdzPfn7DovRGCkWVmu6ABqpZLCqP+4z?=
 =?us-ascii?Q?/XFDJpIexz4KsHo7/DpSq5/i7KnBPhCw4LTNoMKIn0Mwxvw3qPGB7pjrlLgl?=
 =?us-ascii?Q?GlK3XT9BM6nyQY4ZVPtaDFPGwiBVdgxOPr0OT40qgAxO/xjm8bjTUvTWYtzS?=
 =?us-ascii?Q?p2jjUPJGpUcBswRmYrYTHPYaBSK6NnMO2FELx5WP0TIEAtreypdJ01saalgm?=
 =?us-ascii?Q?DgXYNoTjEnx90LKtKO/LhyaND2KPMwMY6Hupht9an4P8bpLgoR/9rD/Qw8UK?=
 =?us-ascii?Q?dJDCR7oH6dPcn1v+EmxTeu/BPIhd7xtDgwkRzCVLdyeM81ImyEnDVqkTmwbX?=
 =?us-ascii?Q?xyEFXZP2cP6yRfsJGTqp22CPvOiMNxat1ZeUkNMSs35Tcp9lKIA0nKa1ggRC?=
 =?us-ascii?Q?BHb/YWezhbKuzoIemIiJ7ljXUnoumuSggFkdPuAyT3jKixDkzt+WRmQSO9R3?=
 =?us-ascii?Q?w3hg38Yxoz6tY7w9i192BqJxq2lA9tQlHlcTb+COmkWePaipsCG0HKwgtQNR?=
 =?us-ascii?Q?m7PdikyDLL1RIlTbq1uOcMvPd3zGVp4rmvSXZMHAkhCMqCRNyXUftB5I1taV?=
 =?us-ascii?Q?vk6dRdBCnPIwkSMLI/jwi8C/jmbzY7FxvTtZDkuygYh0BMI57i4Cf1WgUOJr?=
 =?us-ascii?Q?/VMbDhM3s99p7H6j0T8ri5VQVnpgKtS3+1PK/gehfB7Z6q7PWnFiM8foj9AA?=
 =?us-ascii?Q?ZKIgr6QFf7Pl+QL5E4s55E9I9rC6PWRoMC2AEK8Lr+611ippvCWr0Zdw7Wjl?=
 =?us-ascii?Q?EAKjN2AgjCsjZBjbuOH3lZg/TxuG64JkmA5jwodlJjLYwZMCqPKmVQuPctM7?=
 =?us-ascii?Q?Zs1pNdx+qnkNnAoKHtOjAQEdNsVBZ+asQSSqEiRV0l5t0jIS0O0nXbtPZWCa?=
 =?us-ascii?Q?EGuk0gaMQNg2mDt1yadsnFPkysdJBdwJKSZAj4ISSzCJJC+7AwmpApi+AmS8?=
 =?us-ascii?Q?lFZkHB+ijXLSWv6NTZ7vFIsdd8ewHA6RGt6yw01s/pACZj0t14QfjoLJJwyq?=
 =?us-ascii?Q?Mr6j5EHwEr5ar+YcXZ6FSrle6Go8stARHONkPRQbESgtVz51UZ9qVvFrbHIj?=
 =?us-ascii?Q?ffhFegX1YP58LRhsjVyjs8zORB4ezfrQ4AFzGegwSlJk7KstpWPolrcgYeJj?=
 =?us-ascii?Q?JFcBUoXLNiUDDxMX9OBkfFU6w/qFq653+nRu4+OzLVhvVvexl++axdW/zCtj?=
 =?us-ascii?Q?Q0QHDb1BYz3fxlacBsJMmrDXv/wobGC4tQgOViBP3tshXk4f1VI2uGti/WEC?=
 =?us-ascii?Q?I/DvqUwSndYmZOyfHEQYX+gQDANCNPCPychlS+pu3kYyFhhgJZ3WEhjhI3Ag?=
 =?us-ascii?Q?42uZiu47NgrS+tQ/GpHR9zCd3SSwYleIjbM+AOIL1EZ+XUWj0/dAa+IbHYe6?=
 =?us-ascii?Q?8BslIVfY3K1akz/YoK/ua2Q0CieB4b3dLXF77tU3Je4ZqUldMAw0nFg8AV8C?=
 =?us-ascii?Q?uwEhljIfMLLso5dPFWkF4Q9Fwn2r8+VAkKoW5jsKJQwMvIrL5Yjr34YA8I4x?=
 =?us-ascii?Q?PmvMwwu2z2kgLFu2o4IQ0f7+yI45RJdIcAQW6lW/NurKrrdVRdjmkCgLM+Yn?=
 =?us-ascii?Q?fwXGyoaXGrjO26fvbsx+rdS6RRmZ3u9J/nZVhnlP8UXehtC3r6OXiiFydWPS?=
 =?us-ascii?Q?Szy0kjqd5+NN2bj2nve+UVC1YczeVCI=3D?=
X-Exchange-RoutingPolicyChecked: 
	V8U5IWxPg25duPFJ2QNtiEUaEDZnr5eO3re8rKRGtyzpaFGRI8Tq0Xad22B9ZKWtK925DNKl9J2VLip8FW5JSxUGiR9suq2rmvidudAuMwWl3u2u8ea+gqY1TWpQJYmTA5bDCcYio9h11DsUV7Go4UzpYPSTuexMbqbLjeBD4nDiBTLp27ZS7/S++2ZfanPHeYTcy7A/veR2c+ps32auLETVDR6gz5790hs56S9OM9oJTvRPq09yRAE5ku8ms/wXdwp8+nkw9s4TFqx0esXQdwZVOA/eeRePtiiPTa0cDoBvN0se2z7YfAY0AboIoaelhRcZQxv5w/PVQK3Rw7kv/Q==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5482abe-649c-44d8-b010-08dead8a5a42
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF75D68BA1B.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 05:18:06.5565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sipzh9qpKHDUX+GOA8A9qsAA0EMvda2FhOEQlR0BLZQiClDJt0nznh46bu8dLhEXZ3McHTVZlR4x7jRFC/h4maGhH61OMIWkFm2ZWSCA054=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7677
X-Proofpoint-GUID: IJSiw7TohXuzvvG6N-PpXGbelg7xbhgz
X-Authority-Analysis: v=2.4 cv=C9fZDwP+ c=1 sm=1 tr=0 ts=69fec394 cx=c_pps
 a=Y/Y9x3HtMOqQL+YbCjVQEg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=8AHkEIZyAAAA:8
 a=xNf9USuDAAAA:8 a=vTr9H3xdAAAA:8 a=7mOBRU54AAAA:8 a=t7CeM3EgAAAA:8
 a=qxTolJBQgbHWKOguPvoA:9 a=wa9RWnbW_A1YIeRBVszw:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: IJSiw7TohXuzvvG6N-PpXGbelg7xbhgz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDA1MiBTYWx0ZWRfX36HYLdNRD34U
 qA3orkBAL9GeUe1/XG/05MC2cJLTo1V8vcYHUVQ9Dwhobz+N5YcDpknbFGhRKZkf+gXDR1kpWYw
 TPmofN3gyXJlBVyy9PWkd83Tw2Fuxpd3050RP8QRvjd0PlrefgFk8N+lidtLIIs6t0vMwjqD2Vb
 8jv63LmiRCNDodeeDRwDy/Cg5qeuTtdbA3NKLJsJde3urNLDcY+QhxZipdgvGxIbbX7LO7EFlNj
 5cu24xMz0MbglT5zmg/JM/FPA/A4bdvmOVmVz3XNevliz7Mw9sUmggKn8EsvRooLAunKdWlNgYK
 xgaVTENbC+YuNiMg3w7F++GvN3NhIW0Md5zW+CDtWK2Z0xlcu4Rho5K0aLDQKJc8dSNfEar5QRW
 fmUq8amwVuhri5bHqn7qtAJjn0cnHjdS5EhdwWWndf6jiUvCTJssQ1RyVY1ZUOzfb+1Y91Z0SBY
 G2uLgX6vfPxxPI/YJ5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090052
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 09 May 2026 05:18:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3956

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


