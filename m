Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B2CC4345F
	for <webhook@archiver.kernel.org>; Tue, 23 Apr 2024 11:09:31 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.15719.1713870568611932544
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Apr 2024 04:09:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=fPF4wKZV;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=4843ca2dfc=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N5rx5m001807
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Apr 2024 11:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=MNq6nAmzPZek+VZclz
	EcOzD2L64hxmyl2mMn5whI8rI=; b=fPF4wKZVcF0xjYzFWRgA0ahHtGinCwkBEs
	JVYewT4a23ZzfApF+G3TLPtP4pQMB7vgKutug1hShx5Z/B3es15OX+5OO8DBDz+R
	D7zUsyyLvn9R6wlQXYIuaxPKT1UXxbzt1X1kgdZ1tdlD0Bxl+sOLgK2TkP4v7bFz
	2alQQoRtKBhe4mdwO3OL/npWfmeBuwCQIEbQoMT11dKe8SKi6Fqaz1pyU7IS+4/Y
	j3lKBYrLZTIIi+5UVbwd3vSqqsu4ep6vXPixI5kk92QmdVUAtdahLTcB46I90ODF
	Uwhp0xgYRki034cRtTHKQ3B80nqkWY+eEKGPEkqs7yI5vcORt+fg==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xm4p7at3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Apr 2024 11:09:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFol3TItlXn5w5/CJN66wUcXr8WZldiF0q8smjKGcGH1pbqZrO1jR2fTPxqcXXv2ZUOaxD74iMkf+ImGI/yRzwCtc0yVvVkfKPHcEQmJxzAfI239nFGRKE8yRAYKuP4itm1fxL0WNG/vS/GqAmLYSgvqytW+8BCiUv0zQrdTPUABLYU7RNw5lE2gY+2lTJVlBXkiRikuwFIHtB6RdEW5Cv6lLAjufwv5YdCklxe1ewUk2p5N8ffNwnipqcD+P6HRTGRZSYkUpsftrFoUReXcdalE6p+Cdnc+eyFg4QemSqaaKK5wZe4T1uHX6gb97ZjcgL/9xoTJfrIcqwmPZHQwew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNq6nAmzPZek+VZclzEcOzD2L64hxmyl2mMn5whI8rI=;
 b=mpkkTxBcRbq3pFWPHCrRFMgYRayLCTs1J3pbxx9W1hjvgMIytjLP5ntx6hVileGhuGywNbx8XeZjwuPE95JYnzLHfpOsM0r2YJC0BiUIUClSNGDS+wMNwdPugTqkH+yFELTD+0oT2K4KKC/R+GpBKdNXMfFiWHNgIb4IYlReapP/O86kE49NhZRQRi10zf05/vq2DimziD7q5UMJex3Ll0VlbmtsRFDQG0P0oWa40fx4y73kqYiX83kmyrayGBsH2d/m/3gNtyYaavhmXAjwG4nfDFUh28pLCbB6ZyWH+qY4QB/rzfZ9LQkMOLh84pXN8pkft2qsAR4joXYdWO+pig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7484.namprd11.prod.outlook.com (2603:10b6:8:14c::10)
 by SJ0PR11MB5102.namprd11.prod.outlook.com (2603:10b6:a03:2ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 11:09:25 +0000
Received: from DS0PR11MB7484.namprd11.prod.outlook.com
 ([fe80::97da:833f:8511:a558]) by DS0PR11MB7484.namprd11.prod.outlook.com
 ([fe80::97da:833f:8511:a558%6]) with mapi id 15.20.7519.020; Tue, 23 Apr 2024
 11:09:25 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH V2] scap-security-guide: remove __pycache__ in ptest directory
Date: Tue, 23 Apr 2024 19:09:13 +0800
Message-ID: <20240423110913.1082749-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0099.apcprd02.prod.outlook.com
 (2603:1096:4:92::15) To DS0PR11MB7484.namprd11.prod.outlook.com
 (2603:10b6:8:14c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7484:EE_|SJ0PR11MB5102:EE_
X-MS-Office365-Filtering-Correlation-Id: 2754c290-a151-4f35-ed86-08dc6385d5da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|376005|52116005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?DTqjcGxpdtGjijurFiCfeI7oRT3BVwayTjIcDeG17tiq9d0lAOBVvUR9l7eo?=
 =?us-ascii?Q?fLP2SX0ndH9Aa/sMVoNjWaw6AoOoyVP7BntjYdAZzwTnAlgXmuuYICtx91lP?=
 =?us-ascii?Q?3Ak7fsIdE9OpVUZbx7P8vtSCh/md1geHTgMoL8P6okbD10Lkp3qnFNWnaHlj?=
 =?us-ascii?Q?pfl+SZSnW3DIGaLFI4hcjzrWIySYnw3byzRd3VaOPQ51yeQ6ZpxsXpy+EgJq?=
 =?us-ascii?Q?lODVJQ0nC+W+AyzE7xYo+67OZuLzhco5yei78zeQbnHwbpQnypKfFkCrxE7C?=
 =?us-ascii?Q?0+rsGa8dMKLMZrI04FchzCkugcO3Qs2bqz5aBBxgCfnGBYQc/jZ/zAo8BJci?=
 =?us-ascii?Q?H1tI85voVV6Q4dEna1ZCJum43jUIIh3VMBmUKvFeUsqI1rZrGKz+fxhkhxCH?=
 =?us-ascii?Q?p9kFWUtNNafk/pYaHjBl0OO9VImm508RiajzxHQBkGk3+vLZT3046zfK2E+1?=
 =?us-ascii?Q?rVBK6vsVzXyggbRP+l3w2Gu3J0tImvQZEeJOoyRI10CKxv6KZFFVPC6iLmXS?=
 =?us-ascii?Q?YtIZ4LRtrvlAdqBRc1sxROP7ggXMpydEWWLRIhqwRTXgTNNFaZlite0RYiKC?=
 =?us-ascii?Q?nluQ5yQ+0fy0Bqt5bArZ/lmIPAlLkNQ6P5vEGe5pga9PLVa1jLJ3xbwO/1Ke?=
 =?us-ascii?Q?8MO8Oidizz5yd+TE0h+IEBJjIafSiFYpZtrbKtqKQGhUq0Asw5o7rYtQLor6?=
 =?us-ascii?Q?24T7Z5rtoYr9ICsFAIWw0F3mC6jva0KX6lrMMbMBRnPiNwT8cxkTMPIlJsgN?=
 =?us-ascii?Q?31v2xmknKUup8yVlMwbY94xoZlaPUuvAUctvEBBqidOyE9mFJkfRmS+/+Ynb?=
 =?us-ascii?Q?PboVJsdLMLi/B4o67Y94y5E6mTde6X2yn6xhS0nyXFLWv5kvDCoTE/2a+fyv?=
 =?us-ascii?Q?ofCohT6SVL7pIKblD4QnLaIrkIsnTTv17Q0UnZDth330WrmGSMTul5bZgKw4?=
 =?us-ascii?Q?gUokAOaGm22HYuvI4OxxMM1cIzr6jEiRk2XPBh6QzE9fOFzIqOsFAn3LPaEr?=
 =?us-ascii?Q?MJpV/+UkOjzrRALFP+N9IYgMuoSFhCQDVAPzdvC4R/5IoQJJW2j2ZlTlxiIM?=
 =?us-ascii?Q?1NoTf8D2dM0+5SFPOH/ZQptzJz1Yv9jExg4N90+r/FRE7yKDy4QhOAaQpndF?=
 =?us-ascii?Q?OaGfcFhxBwXQItYMS5FeHePVD2+cVKk2YKZHL+e/VN+y6a2yxsWSf87slpPL?=
 =?us-ascii?Q?4mP9IDujrwDru2QdAzaMXY4ABMWkVKHRfc4MxW2iFY+k0fPtEvJ6YgDJyBTx?=
 =?us-ascii?Q?T3DCUlCsv4Mdb0utPQItbo39gLvYHsVoAGYfrNuDL+cKFw/DNrY0ILBD3W6U?=
 =?us-ascii?Q?dqLDEth7GLMzNi8BeXMOvk2hDD3HDQwFVVg0iQ4JwtxUGA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?arUwwYt3p2AHFOCPxFDilnIZ+KDYAjMyH+QC0SGsmwITuiGGv8EGe/SFr9Ho?=
 =?us-ascii?Q?dVfBBareUweOmQdhwS6adkAslAFiQVKk855XeSEeRrc0MjEme9oyzNzi06SY?=
 =?us-ascii?Q?ig0sN/SuhUq7ik2UmE40Qv8qHPpFmMnmlcJwh3VdBnH92ScVjKUHhvkwpLwR?=
 =?us-ascii?Q?UtMyBHWzQhQhc+2B803x0Yh9EhKAuhSM8frl/UvtVYlKMQSKFn4WNViuOS7U?=
 =?us-ascii?Q?0XNHr7vnFRHj5zG6P0bRcpwtk85etX+IsRxQhhTxuhs+eNYoMzU2I/kRayTj?=
 =?us-ascii?Q?cLf79tQZ5REnbZqvch1oY0EYpcvOJ4VisFJr0e/A00mUSRlEemSXJ6gOlz/q?=
 =?us-ascii?Q?lkp7BHAeKoM5Pq+Zesk66LyEMaID6OhzWIuoGIyB+R+B5ObJic5cAAkMbZ8M?=
 =?us-ascii?Q?XpLQ4WTkMWqgfmdEEJY7kwJSPpFhLZBKIterDglXXINsTiqF4qvc8iK2E15l?=
 =?us-ascii?Q?4kWmCZ60Sfjvbw9a3yjGff74GlShhP1rjK6xWTUz5763cq/fRukD0beEPnjl?=
 =?us-ascii?Q?SKwodVN0t1l340huhYWo5jXs+epz71daCK6UKMWXE8zJbKrYOT/ZjkfGdAhU?=
 =?us-ascii?Q?rgukapDV7fH5Kl8TAOVYu23JWgLI8qMl5CEAXJ3aUDcqJheFhBLrIWeD/X5q?=
 =?us-ascii?Q?/dOv2rMAlMDknUeq8HCtgvB8o00h7Ju/vUUl/hGX3Ciy9a9Rphv4rE5W1ISw?=
 =?us-ascii?Q?9xgFGJUCail12kdMB0SOupbRVV0Sor+2M6nzbvx5TimN0d5N30pl+7CffoNZ?=
 =?us-ascii?Q?qAGDeWl6UyeaexcyKox6PmC3/myjgPbrqQIAlRRQr+6jojETl4hBzvrz+0OP?=
 =?us-ascii?Q?EbliF18EuhrDSEzjNqQrYEvfkGuadkdilSJFnUZpXiZmb0VWPwcrGM8o0/G+?=
 =?us-ascii?Q?ze08n2TBzfleAnjUhwuBftuB/PELe83cnd4PqGe05PjQXvQoYZKoml2kGRVE?=
 =?us-ascii?Q?PleWdScyR36usW/x8j1JO2JiNsZYW9nOk/ilgOqky7fLXuSTqCUr+xr8mSPW?=
 =?us-ascii?Q?kRiMiNhBM3Rd6ZSuoCn9YWif7ifSB6KaSoSSX/9FbfhSq0vO4s0ZHYV1EX5i?=
 =?us-ascii?Q?j3/vGNYvAfRPKYT7m0YxxMaVFU41WJ6erlQqiUhPWQ0rgk8FGHa5cbTiOyZJ?=
 =?us-ascii?Q?x45l1QEUFo2UR6sv7crsVI3sUmR2qqF0hx8nresy00pnqSxl3tBqTqNpilfA?=
 =?us-ascii?Q?PSs9jhfbMybYrgRwe+5jqr+5F2yZ7640QFoMSIsuLNY4020rfnnWO9nInSqY?=
 =?us-ascii?Q?RjSdMmJ0drx4w0xv/24w0g4UpmRTHUjEoUkdtRZvI9of7C+cK0vT9PfidJmE?=
 =?us-ascii?Q?b5yiWuEaIKBLtOcdsMcr0bCbGEOh4ON9EpCFNy9GZY7UF1wUCCCWlRgSA8sZ?=
 =?us-ascii?Q?clhVjPAisXCZM+nXq/PfJ2JWa1C3LC3xn0ATqhlcuOtnqpiEQnT28u0jXzqc?=
 =?us-ascii?Q?RJlDMAUKDPK1Noyi7EBJIxY8Kgmw6bqCtXu7aRJe79VM/HSDV9bLG3nCC+2U?=
 =?us-ascii?Q?3LdEIMO9WMToMCOMyu1pfU4ftzAnU17yKGtBHULPAno6R287MG3z2d95eCfF?=
 =?us-ascii?Q?PClWCwPnrIGuhIzWwenY8InVTx19q6OAyrYkXz0q?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2754c290-a151-4f35-ed86-08dc6385d5da
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 11:09:25.2785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O66dV9dWRsEgt3uluv8CNVotvo5kQ0TnF734Kw+AlkWgqWBfOROaxSkBmtoT9pYhkEP1Vsh3vmTMgoz5Ed4ThQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5102
X-Proofpoint-ORIG-GUID: wGideBkdp2xwXttd4QhmfA9RDEQbxmOj
X-Proofpoint-GUID: wGideBkdp2xwXttd4QhmfA9RDEQbxmOj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=821 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230029
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Apr 2024 11:09:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/55
Message-ID: <20240423110913.qs7M2_bII00ZIvEY_ax1P8z5XbejjjpLimzSckSI76E@z>

Remove __pycache__ directories as they contain references to TMPDIR.

Fix QA warnings:
WARNING: scap-security-guide-0.1.71-r0 do_package_qa: QA Issue: File
/usr/lib64/scap-security-guide/ptest/git/utils/_pycache_/gen_reference_table.cpython-312.pyc
in package scap-security-guide-ptest contains reference to TMPDIR

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../scap-security-guide/scap-security-guide_0.1.71.bb        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb
index 5e45332..43c8b8d 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb
@@ -82,6 +82,11 @@ do_install_ptest() {
         install -d ${t}/$d
         cp -fr ${S}/$d/* ${t}/$d/.
     done
+
+    # Remove __pycache__ directories as they contain references to TMPDIR
+    for pycachedir in $(find ${D}/${PTEST_PATH} -name __pycache__); do
+        rm -rf $pycachedir
+    done
 }
 
 FILES:${PN} += "${datadir}/xml ${datadir}/openscap"
-- 
2.25.1


