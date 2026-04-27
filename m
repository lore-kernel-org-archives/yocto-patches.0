Return-Path: <li.zhou@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD9AFF885D
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 02:59:03 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34187.1777258740220430608
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 26 Apr 2026 19:59:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=W8/auczM;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8577cf8428=li.zhou@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R2M8an2707960
	for <yocto-patches@lists.yoctoproject.org>; Sun, 26 Apr 2026 19:58:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=7X8ZLQXKwOpIGvNkyst5
	8F9HNL+olMuim3h9LgK93oE=; b=W8/auczMwZyb5OlfYjfLAVfRa81RUOcng96/
	gIJLkA3h8BIuQkCW4zmcxnQCDz7/58xJ84mwhCd8LGxqGqvvJlOk0Jp/0LR1mk+l
	Z6RKObrOXDHwMN1ypn65gENdh/lNnD8hV6fyws3GnvJrL2Tt0JM2Tc0YTSH7UVeY
	Henuk5fBUhpYtlT1y8Z90JpeMz473r6NIv+bHZdBrtrj5Jx1pMgGJXHKfxofg4bH
	oZMRAVLapIZ2CTnsQ0o1iPd3KgCRHkk3a5Lqlt5KL2V2WugcShFuZ6dnIaJFxgZX
	lqjlJbTp4Scu0U8wi3MuhWBQ/9odYvLWgccqdQOyDNyOAzuljg==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011067.outbound.protection.outlook.com [52.101.57.67])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4drrw2sa32-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sun, 26 Apr 2026 19:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzkA5aCyEb/CjZ+vlRQZTTMYXYJ8cO/HwNLLMHWE3N5suHjyWVWeGT6OPvS5nMinWqiixY9VG+zDdD9/43ruGB1ZrXPA1oVylWZ99bZ+6SJOGGY2rPq9znUvtesN/Dm6OxswR6yIzUnnohP+0RO4XV6Ir+tJFYC8oOHjoAmB07JwdOZfG7GLEhfT9BIA2ZiOuO2gug/hj9QE9xRihUJo3LZ0F3AXA6Kj7EZC8mfbIAk1ox9UO9EEwwo2TBAUy9VuH//zANsqOyvUWrS/90wYYwO7WLfPcJgqwMKvVq2ZB5150kf9hg7VKO4GR+rjNLSLFdoGDxdAsifzjPcpKNsnqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7X8ZLQXKwOpIGvNkyst58F9HNL+olMuim3h9LgK93oE=;
 b=el20kyY3ohrFXupZAWg3ax3h3HTuRcd6MWgn8bA+KErgGTJzkWBfeLZaXXrbpwtuBWlV85oOnALnQzU6x4SNeqqJAd3aEXtpW0yJFcG8e1uwz16zKgYYxudcZIYGwAU2SdZad5WhVdkQHi+mW3xDPEBGPz/Km10caFBdNJy45HB5y565p2B931Pk11IyULkEiSrVPgJDm0Se/2IC+KCnJMNPY0m8QoF2n+cGm0tfYr82heK/V/c/hC+d/1F+dgF/FANBpiInJ7dsoz4y0t9Y6ZLWVCUs3VkieELSMHXeZlPhyNCnE44+06/wGStPF/Uc78gqaSws3tM3ss3BIadgJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7453.namprd11.prod.outlook.com (2603:10b6:a03:4cb::19)
 by SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Mon, 27 Apr
 2026 02:58:54 +0000
Received: from SJ2PR11MB7453.namprd11.prod.outlook.com
 ([fe80::3198:3bc6:ec3e:b2ae]) by SJ2PR11MB7453.namprd11.prod.outlook.com
 ([fe80::3198:3bc6:ec3e:b2ae%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 02:58:54 +0000
From: Li Zhou <li.zhou@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] layer.conf: correct WARN_QA
Date: Mon, 27 Apr 2026 10:58:32 +0800
Message-ID: <20260427025832.1007513-1-li.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0096.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::18) To SJ2PR11MB7453.namprd11.prod.outlook.com
 (2603:10b6:a03:4cb::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7453:EE_|SJ0PR11MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b6aa595-9327-46aa-bff0-08dea408ead9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	DvaET91DgZSNAu8LN1a9xkqvsaYdOu7fXZGH4KiHQlyiEARMK3jZabSNMWm84I8iOTssH6Z6WjxNzVhuQlRkiAKfXyfDIE/svAV0329/FjWcKmtJ9JOJAOE0vOrY4CYbonI11gWQRPr6Lm8lPEiB7viNZ4pd+D77X4Dm0JvcOdRD2ecO1qFjvqLf/n5PF04LUMc6Gorj/y8II/OQ3BMOrr8OaY1qCtN+maBOHjNuQexCizVSd5Kw0kuvF17faVMNEANhnrZiEHyqn6B8dkaGoa+hZgXhstBb9MGuyA+VpZFX9U7ZKvEAcr4QiVXd0i5FqW6oWXFWlX0868TfXXVDSSly87g7ckf6dY2qOAvVAi0FXvGIlpB6CshU4oO0hqO66lK992VT+ichPv2ZYdVsFDBxSd+439tNPzCS0FIXBeuNgDAL5+NVvH4g+06K7WGlEFqdEHG+s3r5CW1X1GqM5U1CcQkQ64gz7a5CXa8CzS2tIQfndzi3AnPRcZy+wcOEUXCpRV88+6OFxBKrxsN/WaaMX8/shPcZOvkIxuqvYEHWiYFQof5EyCRCgy5Y4aL6UdAbzJZbf3Qk2ZX/81IQUaG+XHpVgDIvDWtbMNiHrbSi03xDhXMmBZ7As5OWWCC/1ApBdzAGLpafCnCTgd3VxDa/AN5sYlR8x1pX7WYIY8Tb2cS6pkfKAsOLTdxJepGAJE3ZuNXqVTzpHh+HFj+OhLsYEbv6HsPh65arT6NSN0TzG+oh1pr/tm/SWjbulR3fsOey2v3XcJKwRWqH+nr0FQLI3caRouQoS5oO4B/utxw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7453.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iD9+UTQYs+dZQjqWUgSFNeY9LDX5V3qv07CHTRPJtMzfxSTMuwaldKvxXrPf?=
 =?us-ascii?Q?sfnPqpZRkAA+fTf/UxwH1uypL618fKjT04WCDNIUqYX0hqlhj1pLAv0irWHX?=
 =?us-ascii?Q?yCKnhxq/4Wt2RoLr8FcvlFAsR4lruAOgpUnqAbF7inHWhUCYzoBfeixa0ZuD?=
 =?us-ascii?Q?0Q1fwszBeyMZ5sOwcksVGttDNaXLadgC4AVSaxaVEAoiKdMn+DbW4LKHZ9Xv?=
 =?us-ascii?Q?gZh76FODWlr80xlnSicKOaJd7LNZznrla0PKa4GePF8jgo6Cy2rMrk64WKpy?=
 =?us-ascii?Q?UyXueOixx6NRXXkmr9EIL1lpgMRX+NG4JmjNtPuGAbDy8HQ+e3BUU9OKdX36?=
 =?us-ascii?Q?zHtkyP4MSFGDZeCFjCMFvUTMUBz6VIaSnePTNkWiMw/4/um/mX5w15Idcv1e?=
 =?us-ascii?Q?jTTLjlaVUX+TauZHZqi4pve+PNUbtIs0PiYWy5wIiXyZTg/WWQrjXCjoGptw?=
 =?us-ascii?Q?eG4+EyTOhNCqxsg5XaenUhRXR77OPzz4RLca6dWiTaJV2aRBkGif7xPKXlf0?=
 =?us-ascii?Q?CrIGREv2YXheStuV7nzOVQUkN5TJi1U8r41pzB5WEPEcHzYNO1ysFMCwg5OJ?=
 =?us-ascii?Q?635yD6ZeI/mDE5kreij/py50CW+ZE89LuvBOvGXO3s26HBqIBMSJZp2eVSjn?=
 =?us-ascii?Q?M/cCnBXuSwvTjQn2Vxsf0gVRF+S3sG6+PMNTP6oqbhVUp+PTVayOVbPKPcZV?=
 =?us-ascii?Q?igFZzpe15On5ohjjjHaYqC6Yd3q1spE7y8QrSJwCZjmPDI9ZmtMfCpiqb0bG?=
 =?us-ascii?Q?pEApyzKvI34iY6rmdJ8Zr1O8XYJQy23p7La4A0HSszF2QfHPXT71hUFvvQVM?=
 =?us-ascii?Q?CdQeUmYdoyX81AFPu1+CWFMogAWfnMaunI7E4ZdM6uIVBudioP6ExXf6WBQb?=
 =?us-ascii?Q?lPGgrwBr6dFipwGNw1WCu4xjWtl9OB0HjY5PsHdjk1olXh0K7y4qnHIBDi+b?=
 =?us-ascii?Q?kBo3oby1DtnVTPZ3jiuilrxMs8sJAKg8KswKyDk2hSdHIvq5GuIqHyXfT9PS?=
 =?us-ascii?Q?Q8tUWt/FasCZcQsf28CWkaPU3pKAfZyPMl1qUpyI9itJmlz0wlHeyXmCshyN?=
 =?us-ascii?Q?NvsoA/I9QRMV0lHMsjAJjQw8egtjJGk4Xd6vh4B0YnaU4a8dKjO3dHorSKwk?=
 =?us-ascii?Q?uKE0VTH9w4k1SgpW7FcUQA3rz5c0AfBQ9Ge5CsULQyZYoBi6I7LVVdmvnQuc?=
 =?us-ascii?Q?QkFXFXB9BEhBZpPRsTWDNHEm427314vJ4ClqC80IM2fcUFSbdsNrJC8h+1J/?=
 =?us-ascii?Q?h1aGdcHaZwceMIQOqjhw15LnxhARlaEPQHfr9CYNMCSlmOrm9lbYtH9t8e0S?=
 =?us-ascii?Q?wAdemMt7h4w/n5FdT7+bL49pbsU7axUJE1DCfuKcNQTghjaQIr9a7CPiA+Ab?=
 =?us-ascii?Q?L7ozul4NtgvPyMEBGbF8C2iIStL2vWo/62YDCfcBQIaq7XhCnlCMVZAgfk7h?=
 =?us-ascii?Q?c+TN9FNMhf3iw+c3mUejtZyk/f1ysPSs9Vvun2eI+7xCdLA8AgrP0I5A1BIC?=
 =?us-ascii?Q?VrDDvnOwKXMue9j6wxEButCim725GqDxTbErqLLt3OvI41ZqAg+93qZCV3qp?=
 =?us-ascii?Q?TUL/IT/sHqmhozfVfNYkWPw/wD9LOGZY9MoUpDOMc3+3Cgch+ahAmbz90Ubg?=
 =?us-ascii?Q?B+oVgTCZ3lJm0kb9GWcLNj5TE5mn5bY2G/9HO7+n1sBj20B9M0sedcgtG4Ai?=
 =?us-ascii?Q?zHVZPvwGXMqBgwYzH+6t/YuP16YWzBl31eWH2N5zDUL/AAygEf33GSbej09x?=
 =?us-ascii?Q?YF8jomFQGg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	kMGr52x5rrBDWl3PQrFpvpb87AbhFclxRXYZl0zhxVutOj5lsHhOuh9b1YZ5a14LvLPrQkBl7cF+gy1SlzGdmQIuywYLlpSCHQvczS/Tg6UyfUnEJcE/P1O0j0yThicBgIsdp0kD0lP2wS//IaaV/cm/B4ajFP2kHaA0fyJnhHtwLX6PGIctqE6uGya/YdHilZYeFsX2OFOrK5QFhTR931SjfE0iF9bTCz2ScvQ6rS8il+XByk3fwijjMUQsBvsbqYMcKiHI6bApQKSo1NsAkih2UZFv9akgT8KGIAiAw00auADZOfUIAEhDz0W36QmuzTmfz+Jdc5SAwBahyWv4ZQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6aa595-9327-46aa-bff0-08dea408ead9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7453.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 02:58:54.2334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxSDYG/+jMLrFtXH+2c7p1H1759MLeNsh5IWZMfkN1mbE8ZXxbgZGfDAvGKrBDmOW3upRxqg66PqeSv49WL0JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5120
X-Proofpoint-GUID: hHNtlFg_IpjM0ZuSgwRSK0QBIFc1-1JP
X-Proofpoint-ORIG-GUID: hHNtlFg_IpjM0ZuSgwRSK0QBIFc1-1JP
X-Authority-Analysis: v=2.4 cv=Pu+jqQM3 c=1 sm=1 tr=0 ts=69eed0f3 cx=c_pps
 a=mt+QW+PagoHSMqpqf5GGBw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=Z8HUXFmqJf30i3-a3lIA:9 a=zgiPjhLxNE0A:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDAyOCBTYWx0ZWRfX5g6kR1chUpe/
 VPf9olF4edOYN5/zEr1pq1LDiLqs0qnz1bUteLyk2wfIVfpYLAlEQBKoMp58MesCDoTTqciv2yP
 hKgtUBixojmthBHTHXzqZMN2jis4cbffg+Gw0ki9h7S7jR1kiI1AA93XbMrVyDq1JhXJhsS+BwL
 DQaBV9HL35PC3hivT8SbEWToyWh3kJLuxVPzmpryQJNoUYiikVA7Utd0Abv3zEyWd2U6739mF1h
 AWoglaOyLaP/f7pSMoR5jAxpYI3b9lwfbVFffQHX9YLFkiAzXyrDpgNhEFE63e0lsEXvX0/T+5h
 zciAq+/sKuPjyMsOfLn+EG3lsC7jDIwMu/m6KfIVg5JlbdsioMZ0hkrOD9dKdBPguQLog6Hj0eS
 ouEJ+ln5tJaHnvThXXGXdVPXrdi1dGCZGkz7hXFYw1dnO3kRNeMl+MfULzMBcTPbiPcp3biJCsr
 VPVWGi7Svn5tKjpBC5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_07,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270028
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 02:59:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3825

Fix the typo "tmp-layer" in "WARN_QA:append".
The right name for this layer in OVERRIDES is layer-tpm-layer
by checking "bitbake -e <recipe_name> | grep ^OVERRIDES=".

Signed-off-by: Li Zhou <li.zhou@windriver.com>
---
 meta-tpm/conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/conf/layer.conf b/meta-tpm/conf/layer.conf
index c0fd7a7..3ea7c08 100644
--- a/meta-tpm/conf/layer.conf
+++ b/meta-tpm/conf/layer.conf
@@ -27,4 +27,4 @@ networking-layer:${LAYERDIR}/dynamic-layers/meta-networking/recipes-*/*/*.bbappe
 
 addpylib ${LAYERDIR}/lib oeqa
 
-WARN_QA:append:tmp-layer = " patch-status missing-metadata"
+WARN_QA:append:layer-tpm-layer = " patch-status missing-metadata"
-- 
2.43.0


