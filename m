Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EACCCFA1A
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 05:36:53 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6718.1762925813251985794
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Nov 2025 21:36:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Om+8ikIy;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3411dc7477=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC50Htb1674042;
	Tue, 11 Nov 2025 21:36:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=ErUm3vZJu
	rnFY74U4Zc+Lpza3KE+tiDWpAIjP/UHu/U=; b=Om+8ikIyAwQr/1COaK9Norl1C
	1hXmq33VgAjIzAHPgKD5r4mzbecUfWb/QIEhhxz+EAvbaF3XDSJH6SVGzmxdItTu
	r5/AWegLYhh0iRoG3VlyrbHPvbAdsPRL7X/9d0QS53BIAeKLdrXOAbGQxd770hpy
	WGAs1RATu93FE/vf41I9xI40srGAKBvQuC52cxyshvuCDpjuqt/+55eo7DoAka5j
	zDeV8JcytTrim4xOp1U5ssG+fxmBEw8u7cu8VAGUv9G+EjKUjgXXopkDJ38fJBsd
	Cj2WG48Q7aBsDXT5dYPtDtg3iVaXeblf+nS9lGr0fh5Tejb3FIPvGY3u7P2qw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010051.outbound.protection.outlook.com [52.101.193.51])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4aa2134dwr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 21:36:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnGwaktsb0Z10evEy4AXvdHSjoWeRQnt1HxHH6hIpY1GFeNriVUHyhuiFb/ZpxsPl+JlVqjuMGsi7yrp02Tv1/HI7Gd2WYBEQDd+dYASE5K+WeAVfJIjemrsO11ItFgZATVvjuC/tDFjJjTTjGNVEiszigFdHe7T7DAb54LlQwOYX1hviXrUa21NoCYa3U1So1Ie0aSyerQd0cv1KPpqRK5zjBzBwW5o0QJvyONh50YLrHKuw5glZnVDKAaQETS/856I4oXsptJO5zgCHs26b8pIw9hx05E3Wm/VXc38kX9eaV1RQz3bSqk4A4GzrEgA0r2VmojUI4iIjHHKe5ZeYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErUm3vZJurnFY74U4Zc+Lpza3KE+tiDWpAIjP/UHu/U=;
 b=TXy9+LLfB3kUCUVBNUqhJe0DTC3IvyhY/4vsdtENbAkhnp5Xm4Gyvik/PxdML/MHBkyL1wGdcPkXUDSiNMb0BSuxz6ierDICjijIB6iVLa3WB8jdUKyvn8vsFHpiwREiE5LZRQE4up48yfX7QgShYtD7oXUe1+NdDRK/2jQrQzZQcvxZbkH8lvgo3taMoY0F5KZgfPRf99XsQ3gY/cFsZXOCJ1YJk6KzywwOIDMQdJ9pNlCGQ3mpB2Ff4faZG9ONPu4JECCAqDa8dI4fDFuf3fp1/9VO0jU8CgQVeZwuaiRLJqxB4Xpjm292+H5B5C6EOiaWp/PqJxRQlHmJMgDfiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 05:36:49 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 05:36:49 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com, qi.chen@windriver.com, paul@pbarker.dev
Subject: [meta-mingw][PATCH V3] meta-mingw: support generating Windows SDK with no symlink
Date: Wed, 12 Nov 2025 13:36:31 +0800
Message-Id: <20251112053631.3078261-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0012.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:17::10) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|CH3PR11MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: 6848695b-921a-4ed3-b5b2-08de21ad79ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gYHegkNbFl7ECh28OwqSORnIEJGSe8DUejW/UNXRvrHmHEXVeJA/yscUknVI?=
 =?us-ascii?Q?bP7z1tkSlSchBqT9srf7Ftc8WRqcoQjw8xS/wduKWdwPwFTp2NxW57FuNas3?=
 =?us-ascii?Q?qOx2tRlVCqClNzEdj91PSrGAsyfUo4OUglsL0q0QunZnE1vNPQEI4GG7EQ+m?=
 =?us-ascii?Q?qJYbPis9b9gTHGSJb69tuc4ZM+l+8cgVPwRiobrjgIIDdb0Eqj10UREXU5YP?=
 =?us-ascii?Q?xSDNISc3mkw7T7xgk6A0sAPLt74Pxf/3Xj/VoiH6lPhhx3uFYiDc05VcrPz5?=
 =?us-ascii?Q?6piS0NVkAsM3xtQhSBI343PzVAgJ7QDUq416+xT8EovECjjLQnzt6BiyZyez?=
 =?us-ascii?Q?81AHqjPQ2cAzT3+GuE2OMJIZEv70bPlLzkEw2M4QiOFL6bYcyrnyoYzXEtmI?=
 =?us-ascii?Q?gzmWLfLl/ObnlMKLiEk6NGKIG63c4JTyGqmFnYMziAwS1MKjZJgUsTPNiPZ5?=
 =?us-ascii?Q?St2eKFNWQzf2eYaF4x6LSgyxEkeAtFdfBzvegMTY1wtw0hFHSYGPPnEM0UOz?=
 =?us-ascii?Q?tEVbQJnA6nJ6IBW9IaPtW5koCXmqnRfsrvWHqdAgdHWIVkBJlcnl8odhV/Fw?=
 =?us-ascii?Q?1VDzTYi35CGYUiYejEfGA//DRss7wDSIi+I96GF6bnYsDgTeerZlusa7LsAQ?=
 =?us-ascii?Q?xvARV00feCvg0dz/JxoiRu8dfkZGSfXefgdYauje2HwSLMCRy9u/nfJHwHe8?=
 =?us-ascii?Q?0WkHW35QZgxK/hrk/uyavTTTVhDL6EF0tPHipqKz8evuEo03Uy5CZJ27g+LJ?=
 =?us-ascii?Q?lOz/1aYuhbHC7/eSTk/eXr+4ONdGWKS3XaBd1rWPsYSqxoqCmPmO7Bb4yhty?=
 =?us-ascii?Q?jsHp2UMK5qOCyV2WOPCPU71GEndeRZ2Zh41NyR+SrHXaI3S24IXeyJGdISCn?=
 =?us-ascii?Q?vuLmYCfoNYFoIvqVYKaPlSEX0+q+5g827C1UoYiSKlLBPNysf/rxSSNN0lyY?=
 =?us-ascii?Q?resgoM85T2/LIFwxvON49AHfOYDIv5iWpdkmC8mQsJiEBzK+3699/N6+Mssw?=
 =?us-ascii?Q?Vo6ZKyNPjw0+nqgU5QkSXxLwroM15ctKLRIb2wttHL5SQrViUCWvOxAwU5/l?=
 =?us-ascii?Q?uSvBA8nu6rTlhPCDWpkaQp3SYtwTrU50htfSWhXCqdguM6dH6Q0kEt0YlXJp?=
 =?us-ascii?Q?oKM13aqAYjz+qhzG69wxEwiwyVt9CVK7MnFuMnShIof26aegCFga0GQI35gl?=
 =?us-ascii?Q?oQMyoyYmOW08ImTo7uk/Hhn0zhZ4bNvAMGd4n+Kcpc6LqPOCeoJybweHiden?=
 =?us-ascii?Q?yUksYRch72nkjIgUx//bVrBJcdASVBT07UId/b3OcR8qSarozOshdkT9n0sC?=
 =?us-ascii?Q?HlO9k0o4l0Phb0F/+x4Xxv9I+/6JQI42iT83++y1x5qVWS7TuoIbDWs6bGiE?=
 =?us-ascii?Q?/ZO3NcVVtVylp8bUtOjFhjZ5ht2lnYOTihRxv56XFkzF9XiDR1G9tzQgaeYr?=
 =?us-ascii?Q?LdE+cLkY1lcXSWqpU1m0PaTf4nfAdk6EAKDSGZWVeoQS7SCAFQvKrq4ET79L?=
 =?us-ascii?Q?hhV0KMWZ19wzNpKF1EHO0uTXkzwwDkDq1tNA?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QKkEjqCqjNr+DWsoGJdM73mLkVzCRJNXDD84UFdGMI6g6S/o+qioae1dKK7e?=
 =?us-ascii?Q?GEjOjq7sDsorxZeFTVukKdNF6oO3q7El4DarzBG13IAqNPJx0xewav8Twbiq?=
 =?us-ascii?Q?T0wjWxNcUyUcJOcsgFNCXS9CuVohiWbFbkphUFBgt9BR4hrd3up3aP76ZU/q?=
 =?us-ascii?Q?AaEoCoKqMp6tZOYfyuHhOByLRxMxiTpvvkQvNqcI+uAG72HyOSbB+vFOlW9q?=
 =?us-ascii?Q?BecPD7gIkmyvWQDIUQnhmxp+26sIQD98cs71jtit1zRq4vC83+24Si6Qtap3?=
 =?us-ascii?Q?ry67qy44y3ZuumVerenKNRJ0EKMV6bDwIhQ053HoNkcKnpe6z5AWi3qsklvT?=
 =?us-ascii?Q?WXD01mBaQHO53/ls8NvTb+7aSGxxaJ9h7VtrVqLlMNDfc7zM54Mb+S3fCJm6?=
 =?us-ascii?Q?l1XT7z4aviUYt5kGnSK02LAGlM/ozvmDKYNAmS4f8B3kZqWvDhc3YHysyPIN?=
 =?us-ascii?Q?EYnTsECvrEzH5KIVLBVR2Ra2aekeoj0zvBhTEppu4N6Naq96ks9wsoeoi7By?=
 =?us-ascii?Q?GdawvRKDzeZs9oQV0vYA+CaMhx3pjN8OEnNzvn+V87OPGLPJzGXaUmF802Ki?=
 =?us-ascii?Q?wa/ilx4UwcC4PusjQVBSJ1s2tQF/UEiBG+kQPNzpZNfmwldQMqZH7ur+PMdf?=
 =?us-ascii?Q?8BMZKUeSAe2HS9WXcb96JeDvpRId3UQ6X2q92MKS/jnbOoYILsXyvRrW4oor?=
 =?us-ascii?Q?inBkexXYwOjvfxlLlgEavKwnylYIVr1ixoqXPk8aJOTgpoDd+qKDw76LjY9C?=
 =?us-ascii?Q?tXP65Ub1FI9sKsuCAqcowPpfeAEIonxRMKv0b6I1ZmZRSVuqpqE07uc0V55g?=
 =?us-ascii?Q?gFWXmiWJfsSD0mhtyNt1GTJPQJ+vtXiEwZXMKVE3/3yRmHjEhWD5SYvYV5FB?=
 =?us-ascii?Q?gxfhmSQeL/bic0EKpj6F8CBfh/KwIfU8oXidDMN2q/GXd9r/TPTvcoMSQVNZ?=
 =?us-ascii?Q?LBzSdUzJ64XBdk34mUE2pUysHob0o2Ttvafl6SXMeAcv5nm0DNV9zkexqpup?=
 =?us-ascii?Q?9KSa20Po3WbZrT41RU2ayNLvRl1/QJwpsLgObw43GbTJsDtxlqFk/Bf/D8aL?=
 =?us-ascii?Q?aNrpQWtQJZhAUGx7SG+jSFajjx30nGywAldII76QxGFaEe41ZO2j9HxX0lsr?=
 =?us-ascii?Q?SBP/haElZ7ZsI5R0Kse+FFQfdZHR3KMHwf8gzU/W97iwrFcEcp+lQFSP8jGq?=
 =?us-ascii?Q?nCDRkpEHgndy5eSasaVHvkTlv7MFViLd/8sIUxf6U0YeHppALXMIoGeD1mvj?=
 =?us-ascii?Q?Lc7yBVt+GJgVnGGcC0eIniORNe+x/IlXvYHRYUe4kGX5k+U8N3EfU4AG46mn?=
 =?us-ascii?Q?JRHxjAFPR38kCmA8WUvlPEfdM7g/5d9JnxqvNSM7W+fsYG9s8wDSZm2YkcV3?=
 =?us-ascii?Q?mpdn0EFIZOakzHEvEKAUTgWR+3/I79Ch8W6WBLe8wGlBhgqRaFtj2ehpL8sj?=
 =?us-ascii?Q?s7KL92t6SVYorV+/q9dmF63RnU+UyaAcpLkUj1XcSqXIjCBajGrqOQjwSKXM?=
 =?us-ascii?Q?N+zE8rtvV6VfPTdsZghbdK4YLDcDXt0INxP72+dgGVmEFSOQR7J3Aszjznez?=
 =?us-ascii?Q?ezLX6wq/XDDDhkxihOwFz7spfLiomU35+cd5AJyI?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6848695b-921a-4ed3-b5b2-08de21ad79ff
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 05:36:49.4542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZK3w8pY6CE6kEIoFsaXkVqP7eII/Zb8619ZrQuL9GFtGPf1AJoEjBNjAY+yHp5dAef/L4x6cLXFJqu27VHMvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8701
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA0MiBTYWx0ZWRfX3r97Yz14Yuk8
 gDEC8X3s4JV0/09hikGEZZPKCxcfq4lOnoaskfB70snQzkyrsFOGzyOit4xdAF8zLYvZAqgIbTG
 cUKWafjYMA7ap1mi8PG0QqyOOCQg6VCfLtfoHSoT6b+miHLep40/n6kdMrR/J5FzgnK5FyIIi4d
 qnnPCvxyatzH1JSfgM99NpFS+/nESkW+P1NK0xedS7gLwxC1hlkESVmx1Uw/zo/kB6eSxJhEgIA
 +bD9bUr8m1chsJZQ+A/OTgz40EC3NokSN1Japw6tFiAS/63Zg+RIlJpsFxlLWOk1LQRszfMfjlE
 hRY62ewm/FHqk45pqn0edvX5ooe926By/O9dhWLX5k9DB6yZjNEf/TgWrkElqGLGqt33pHXWp7u
 tW+A6CkYCaO/sskK0c7Pf+jo9fvmCg==
X-Proofpoint-ORIG-GUID: YHPqE1CI7lHTWzBPNCq95Qgcaq3KvON5
X-Authority-Analysis: v=2.4 cv=XPA9iAhE c=1 sm=1 tr=0 ts=69141cf3 cx=c_pps
 a=kgXPJ/cF3Xw5T7/w5pCavQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=LtwcJJPwdmsIudEpcK8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: YHPqE1CI7lHTWzBPNCq95Qgcaq3KvON5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_01,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120042
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Nov 2025 05:36:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2489

From: Chen Qi <Qi.Chen@windriver.com>

On some Windows systems, symlinks are not allowed due to IT policy.
We need to be able to generate Windows SDK without symlinks.

To do this, a new variable, WINSDK_NO_SYMLINK, and a new bbclass,
mingw_sdk_handle_symlink.bbclass, are introduced to achieve this.

By default, things work as before; when setting WINSDK_NO_SYMLINK
to "1", SDK will replace all symlinks with the actual contents.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 classes/mingw_sdk_handle_symlink.bbclass    | 25 +++++++++++++++++++++
 conf/machine-sdk/include/mingw32-common.inc |  3 +++
 2 files changed, 28 insertions(+)
 create mode 100644 classes/mingw_sdk_handle_symlink.bbclass

diff --git a/classes/mingw_sdk_handle_symlink.bbclass b/classes/mingw_sdk_handle_symlink.bbclass
new file mode 100644
index 0000000..2f6dbe6
--- /dev/null
+++ b/classes/mingw_sdk_handle_symlink.bbclass
@@ -0,0 +1,25 @@
+WINSDK_NO_SYMLINK ?= "0"
+
+archive_sdk:prepend:sdkmingw32 () {
+	if [ "${WINSDK_NO_SYMLINK}" = "1" ]; then
+		for parse_type in "file" "directory"; do
+			find "${SDK_OUTPUT}/${SDKPATH}" -type l -print0 | while IFS= read -r -d '' symlink; do
+				target=$(readlink -f "$symlink" || echo "NOTVALID")
+				if [ "$target" = "NOTVALID" ]; then
+					continue
+				fi
+				if [ ! -e "$target" ]; then
+					continue
+				elif [ -d "$target" ]; then
+					if [ "$parse_type" = "directory" ]; then
+						rm "$symlink" && cp -r "$target" "$symlink"
+					fi
+				else
+					if [ "$parse_type" = "file" ]; then
+						rm "$symlink" && cp "$target" "$symlink"
+					fi
+				fi
+			done
+		done
+	fi
+}
diff --git a/conf/machine-sdk/include/mingw32-common.inc b/conf/machine-sdk/include/mingw32-common.inc
index 56b8052..7cb1f9b 100644
--- a/conf/machine-sdk/include/mingw32-common.inc
+++ b/conf/machine-sdk/include/mingw32-common.inc
@@ -59,3 +59,6 @@ GCCPIE:mingw32 = ""
 
 # wine and wineserver are required to test MinGW SDKs
 HOSTTOOLS_NONFATAL += "wine wineserver"
+
+# handle symlinks
+INHERIT:append:sdkmingw32 = " mingw_sdk_handle_symlink"
-- 
2.34.1


