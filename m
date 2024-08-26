Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC027C5472D
	for <webhook@archiver.kernel.org>; Mon, 26 Aug 2024 05:57:18 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.46496.1724651828824133499
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 25 Aug 2024 22:57:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=896858a60a=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q3qJwZ011326;
	Sun, 25 Aug 2024 22:57:07 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 417f1k9657-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Aug 2024 22:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDqVCyTIv31hTTzs05nIz+K/syYdLjbISsJk5s/+O9OvAbElpGuiiNMffXwfWMRNIPFhHD2CunGXxVlq103BkyGaUPLxOoYUofh8VOjllZKBgyJP1tJY07MamzXioNQL81uxYSGEX1ShBhoFbDzRIj61M94Ya7RR8gwhKzyIAUp2Il5ks8t9C7HDhr2wg6quLfy07y1qbDIXDaqVk8KaqP2xupQU9jL4QeRiza+pQV9vYamFqaAvv8L6rz0uJRZGO1njr0GNuh3xSiYQ/AlwB48DqewJOH4g0SzqBUeX8F41izdsYvjZkfFNNuRpJfLosCdMrWd/Am3k/ySA4aIPvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffYKnlUwrti+vHsJlw7UavboNUnXIv0w57ekgG2gDZU=;
 b=dYuG6TmVd1FnJZj0EB0TsYaCnJ2DU1ffiafrDZQp9tOYRnIridwqzDfdh18Il6OG2Q+ynNixdHP4pboMMsYITNtEfdtSFruCyPV53I/fdn2mZiTJ7W6Thv29jYayO68+ODYXglj/zIsOCvyEtHywiyfZ+SgGzh9Q63b9CVBPXgzK+aQEf6uoHnKXE04EEgFU4CesGmBW0mM35/ygumBRmiHCkzMDkTdLxqPUzg2FFd6XLDe2SFQcDwc3GQ7m34iL2j2TJXuE2TTIA+Faz6F0LheJJQWkFW5SymfzFmMGjpmlNKb0gth/yWcB/tGDY9AQFXj+mRMVQuGXAZhsT+JmoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 DM4PR11MB6456.namprd11.prod.outlook.com (2603:10b6:8:bc::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.18; Mon, 26 Aug 2024 05:57:05 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 05:57:05 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, joe@deserted.net,
        joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH 1/2] mesa: rename mesa_%.bbappend to mesa.bbappend
Date: Mon, 26 Aug 2024 13:56:54 +0800
Message-Id: <20240826055655.264086-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:a03:333::20) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|DM4PR11MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: cf43856b-38fd-462e-1a0e-08dcc593e986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pEEsyTE0/eHol9LZkgdQ7sJwcElEGCJQnNzyf9Kt9BP3CjHXrMTm4191dHD5?=
 =?us-ascii?Q?F2wL6v4gwdX6l8Um2ClGzrdBtJSNb9Pk6hd8DefbQjI4K9zMTluRgl6GurAN?=
 =?us-ascii?Q?P+yikXgqCy6Qqu84xIGEms+Dj3TbKjWOTMRoE7LC8I7YifbdBdwDhfVOo/+l?=
 =?us-ascii?Q?IT292ZfAjxIVgg4zhFUPjhNviVAY7aUnBPpxtBco2YlFUU9xPljyEDSJhbBw?=
 =?us-ascii?Q?cjIn9g5e3tkd9WVJ/qpbju7gkp8yP3N75w/m3b5tuywUqpRc67XyURDQZT3k?=
 =?us-ascii?Q?tK4SqJnhxANIBoJChNr/xdmrCgq3iSgObplTwG5Vjl3Kk8q/Tnwggqyyw2Gh?=
 =?us-ascii?Q?cKQFmEY8tAI6bsXmvys+r+BPNvEkdxLcnHErzE1UyXCPBwnefbvcvqUZ2jfC?=
 =?us-ascii?Q?6EYR3JXpKOligm5rWq7nfgMnDraQGqH5CK+e4a9AsqByihM5xpA82PNyPuYx?=
 =?us-ascii?Q?Q8Bnjvp6UDTFAuuGExO91xuHkpfTDg0TtqV6VsvRKrP90JB5hKad9Dn27pRq?=
 =?us-ascii?Q?dPCKLss65BUiaIYd772OQM6paZ3UL6S2FFji/IFEfJ8wWYelH9kBvJLXT5MS?=
 =?us-ascii?Q?jkkM2b+/WHa9OKoU/jk2jOBX2zoOq0463KJaLdIcdSSLYHzPWV3MTZfwSOzM?=
 =?us-ascii?Q?j5DYjK/nMEEKY1r2IJJgWvtEDvbDFR+f0fgwOBT6Ey5wZdDv54jTHZT+xFsB?=
 =?us-ascii?Q?rDZIDOckdv4s8YC5vkm+oitxr50ZNVMd+nJV+IR/n2VWNYP20VlNOC9ZRmnG?=
 =?us-ascii?Q?3rwkWPm9gQ0YbufNruByo1Er4X4oyRe8c1+t+cVXKwRnJaZ5UV7bRSEfCnef?=
 =?us-ascii?Q?3KycPCnvZGciZSULRH3pHHUrXLCRL00d2kymW2fPy/QfScQXdEihpg3JLtl8?=
 =?us-ascii?Q?g17I0wMUS7qXENgwCXvkMjtInPpaArhx9K03OQ3gRRTcR9H91c6MpMCFGU2f?=
 =?us-ascii?Q?eM7JjvstX+xrdWKJHAu2PgxiuEWtHyLxb80zvLFgvrm3LL3gFExHHWN0ThRk?=
 =?us-ascii?Q?hvfgqnSP3NSycLbbSJx4xmacB+4UrjE9gpJgTQ8pmZ1DC2iorC0CZWgDaGMi?=
 =?us-ascii?Q?Bl607iCKRg/B1WUIZlGUUtJvmrSltoNTjVXUGkZRNyiQi0D0oKt630j9w3k/?=
 =?us-ascii?Q?UiSkZT+e0if5/lbG97UXsLL/9iIpFbiQEe8V7ZBftp1TIOqqC9vZSdLX7A1V?=
 =?us-ascii?Q?+jZdA/BvJmifc2+SfeimvhvE5hHyVfXKosLtazpqwcre0ZJlHYLle2XskqID?=
 =?us-ascii?Q?3ntLEG/dliSRKsHtn3gj05yA+MqsQn58kJedv0NtfG/dP4psYSBhgKfB6eak?=
 =?us-ascii?Q?5k1nPamqj1ajQzwqcOz+kbvZ2phJNRdLtv784tVeaRMYAIV+BYOj48uHVv/T?=
 =?us-ascii?Q?1kJX3NM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fBEeZp2Pn4HDBeR74P7a/4iSjkl3w60DThj2w4+m0wBtEP18kjR/VJ9c3Sk4?=
 =?us-ascii?Q?3HjNMI/O5aDjDnyQ+OGuS/cyHYjZXPSv4IqWE9i7fBR4rA+PsmoKQuGp9RNc?=
 =?us-ascii?Q?Z39+OSXDLMD49xvQsKDoasFtKcLD5kyjf/HQDBFZYi1Xv+qyokI8wmXupR+h?=
 =?us-ascii?Q?2j5QumUwmDGCaGiI6PFgSLQQFP9mrEXjpluWUdYOB9MgA103gw2xUBygXU2/?=
 =?us-ascii?Q?qKo0SXXlbvTmCU9uurkO2L/va0IwbvUtzyly3uPkzTP9KyRCbXgzpLneD9Ba?=
 =?us-ascii?Q?oBJIjzU0nbBQIRFPnkHcahl52kDZ2Ggv1JFEU3ZMIXLLSNCci548g+F5bvwQ?=
 =?us-ascii?Q?Z/gPOExWGp2tpTs3j2GD97WWCSBqSaKe+umpWv9WYsB8UbMIMqHbTb6ILpyS?=
 =?us-ascii?Q?7CwMv2pAmAOasBla9CB+HhZs5d/V/V17P8fQTSQTBBhYjINiLybFINaS1ycy?=
 =?us-ascii?Q?aXH89LuXShaWBoishGYVVboULJzN3LD20Fh84757ymYHBqWRQ8qIigM+olw5?=
 =?us-ascii?Q?992dQS44HDCIxlmo13iWbS2e49HReyV41feYMdShrSe7W2Rz7ap64iQiLMXC?=
 =?us-ascii?Q?tjcNtYUgdHdyPlontQ1q9wSeynD6jyNfzH2YgH+tFLdh9odlfLtcPc/E9zhs?=
 =?us-ascii?Q?iDbvHscVoZ+wAnQjErrkxG03AArvbTZfIFyOdwY+yKOVANjXTEI0BnN9ieQZ?=
 =?us-ascii?Q?BwEnNI3g8O44nOePr2K16EvLZ+eOmXj5HnEKaVjjm0xw/8pFDPvrlo1xY2/A?=
 =?us-ascii?Q?jNtQeoj7xYQVIuQ0eQsQp9l7phkCFkMNHoCwLYOFvEhpXdwmEGLRr06OC/rt?=
 =?us-ascii?Q?z/hCm0kDL2oAsK4fBosgTqHgvGmcMGRHlvisWS/SaeOED6M+m/c9SlBzmskY?=
 =?us-ascii?Q?yQl4jtXiAxxOPg1UiZN2thYtffM71kvX9Tlx3BWVgkiSSEEkbvc1Gs4QfGK+?=
 =?us-ascii?Q?/jtwjltJIt4vpFcu/xdGw2cIpLO86c/N27ZHwdmZnHjVzycNDrM/92ckDIa2?=
 =?us-ascii?Q?4o/cPCswfaNJ7y3IDaQimJJwlo8NmjthzVDpdSafXiKl75WdHgmRwQAyfXQh?=
 =?us-ascii?Q?xNFBh+DYP1cgzksgmRJrhXUC5cBZ72lTrhNrVbzBONA/ZLVFDDKvNYBGp4PG?=
 =?us-ascii?Q?pRtfjCPSyBT031U/poA6Z1JRujPB4XpbyA4Wu4TwTo/fWk7yF5+b/hfIhdhJ?=
 =?us-ascii?Q?TjRTlHbjglyTgyYItyeDbeLSvrmcm+bgXRdnmR53i4YFtPDcXUzHI7lxIu4U?=
 =?us-ascii?Q?+ipS0jro9Cf9kELdkMMk7g6sFAEjQqGI7EOdKm01LbDr8fbgmvBbGznDv3b9?=
 =?us-ascii?Q?wpP0EcwifdgP4w4rVA8c9bTlHwEpoTZl85ZzlJ/RQRFZ8GEjfW3ReipxyCMf?=
 =?us-ascii?Q?oHlm4e8bDK1pX5dws8MzSt56XZjVg8XghhOjDmnxEwQW0t+zj3BApsPz/YfG?=
 =?us-ascii?Q?whFuQgy5iFT3dg1UvuCJ1vfcNaTqu03NPOy4I95vNFv1sYJanixktcDcgngy?=
 =?us-ascii?Q?2oq3ywZQpXmqHKGVjy7cociW0cBZDZTVZ+pncxHsNcdJoW4fZ916pVFbLryl?=
 =?us-ascii?Q?jZ7T1pMHQoHY/jad9DdI/5XxcN5UJNKe6tu0PYvW?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf43856b-38fd-462e-1a0e-08dcc593e986
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 05:57:05.1646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlW3jpYLfFs8y7wf7o63SJHAy4zK8Kqh5k1ZfWRIVXhNOGd4EaT6m8mNEazpX9OydMW0qr2/5YH1rVa+qgDPlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6456
X-Proofpoint-ORIG-GUID: f-h2xxYEMg0F_bToFdAVpUhcDPpfafWZ
X-Authority-Analysis: v=2.4 cv=McQ+uI/f c=1 sm=1 tr=0 ts=66cc1933 cx=c_pps a=mXs27GP3B2XOU+bPH1EGlQ==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yoJbH4e0A30A:10 a=bRTqI5nwn0kA:10 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8 a=hDyfDOjLfUoTN2h8myQA:9
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: f-h2xxYEMg0F_bToFdAVpUhcDPpfafWZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_02,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=718 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408260046
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Aug 2024 05:57:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/560

The mesa recipe in oe-core layer was renamed to mesa.bb in commit[1].
Rename bbappend to adapt this change.

[1] https://git.openembedded.org/openembedded-core/commit/?id=f5cfb3e23603cefb2f3f6bfe776afaedefd10808

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-graphics/mesa/{mesa_%.bbappend => mesa.bbappend} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename recipes-graphics/mesa/{mesa_%.bbappend => mesa.bbappend} (100%)

diff --git a/recipes-graphics/mesa/mesa_%.bbappend b/recipes-graphics/mesa/mesa.bbappend
similarity index 100%
rename from recipes-graphics/mesa/mesa_%.bbappend
rename to recipes-graphics/mesa/mesa.bbappend
-- 
2.25.1


