Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699CDC25B7C
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 03:13:34 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.5096.1716952408053294149
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 May 2024 20:13:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=6879142b9a=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44T35jIq000549;
	Tue, 28 May 2024 20:13:27 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ybb90bj36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 20:13:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUY29QI6rVgSDGhjk6gnByddRIKvXcZ5Cxa8/081YIeqQUK6q2y4bx59z9BKpe7NCmXhktO2ssacP//NSm0S5qGztN36i8oSMkzPmq4hYkCCUJi9PBidyJ9iDzUHFXGqKvNL0CA9WklTMg1buUTOsTvt+mccLGbHI7CsXZPiIKlediz71DOENZUVm5mw08rIUla9ZdRR0Tqc6mus3kGc3T/kTu/XOrLdVp+zXwJRI5MEUBSEk6R0qQwcPHW1jnfkftg0yAvvo5yvjUkS2nKdBo/HSo7BiD+XgQmcrB5OH0w1Nkvmg1RFePDta4Kcxq9/bVjmgPJHggfGOBPiMHmp4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxfpzCu8x0NwE29Wl7CjIzxpIWSvcdxAU90tTv1ExmY=;
 b=A3rCCTrXPO7N/xh7/M+X4crm+V09R2JXhEXj8WB8FkFfUrIbKjrmPmeB8Jq89CeFO8kYohmCM/tywbfPiPoMqoBA9V3LaKqRYFLp5LEynVISq3V2Qxsi5IZ5MiTUD3pzoxBsWxZs9kCjiViAQry3UCBki2r47EZ3Fd81NmJbB1+KuyZAN1Rs/pK8nxPfQtw5qiTg/nmEfJYveu+A3hdqDrLGR43Aq0MvFrVLEb0V+DyEVOAxVjhWFkKUX3BkXHS1tGgei7L9nQVd4bH6uEYrF3v1yO/UMyQJd2RfKj+3uP6pmkLV9972oInSzAGU6LeCmBLLVpdyhea9nnjnNslPyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7484.namprd11.prod.outlook.com (2603:10b6:8:14c::10)
 by CH3PR11MB7250.namprd11.prod.outlook.com (2603:10b6:610:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 03:13:21 +0000
Received: from DS0PR11MB7484.namprd11.prod.outlook.com
 ([fe80::4e72:f734:5886:b658]) by DS0PR11MB7484.namprd11.prod.outlook.com
 ([fe80::4e72:f734:5886:b658%6]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 03:13:20 +0000
Content-Type: multipart/alternative;
 boundary="------------SBE5En9gFvFZK5TZdIG40zfx"
Message-ID: <854527e2-c51e-4580-92f6-d498088975f6@windriver.com>
Date: Wed, 29 May 2024 11:13:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH V2] scap-security-guide:
 upgrade 0.1.72 -> 0.1.73
To: yocto-patches@lists.yoctoproject.org, akuster808 <akuster808@gmail.com>
References: <17D390C542482B45.24533@lists.yoctoproject.org>
 <bb06fd56-1a73-42d7-b6d7-98032d57e5b4@windriver.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <bb06fd56-1a73-42d7-b6d7-98032d57e5b4@windriver.com>
X-ClientProxiedBy: TYCPR01CA0183.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::19) To DS0PR11MB7484.namprd11.prod.outlook.com
 (2603:10b6:8:14c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7484:EE_|CH3PR11MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b81e78-bdeb-4512-f34a-08dc7f8d4ad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y2VQTFIrVkRxc0J0akVLVDMzeUFTTVB5ajBwUnVXeGlDK0FSekZvcVBDNmJS?=
 =?utf-8?B?WUVTMjdwaGpSSFdpcHRteDBQYmFXa3gvTzk5a2IzNVl2Q29HeGFqbmlmZ0ht?=
 =?utf-8?B?SWhVSGtDMDZlZmxFTWpMSU1OTWl4Z25lTmtnWmxqU25iZnlKRWI5eFR3bldw?=
 =?utf-8?B?TnhRU1lleCtXSmdTM1BKRXZPbU9vYmcrNnl2QkpBaFcvQjN3NXByQ2ZtRGM1?=
 =?utf-8?B?QXhwL0RXY1llNXYvb01ZTTFNRi9VM1JrcmNUTG4rUVNHRmxPYVJQN2o0endx?=
 =?utf-8?B?cVpLZlRxSkwydGFDYzMvMndKSnU1ZkJ5ZlRlcHVjU2luYVUzTGVkSE53cklN?=
 =?utf-8?B?Qmd4aUg1T0lhYUR5VHowM3RJTnBCUE5kVmkyQnVFSHc3TE5tV29RUXlqZlVU?=
 =?utf-8?B?QzUvclg3Sm9hRzBSSGdyOHFNVjN3K256KzN5Tnp3ZEpBaEt0TGhwRDdtMkRJ?=
 =?utf-8?B?bFN4VENzN2ZTTzljRnRRNCtpaEMrM2d1K1NyNHYvVFl3U3BMV0VUcmhSVXJE?=
 =?utf-8?B?QURPUk9iampnSnNwUFNiajJQN3JGa0o5M3l6VEp4R09JdzkxVWVJSnRUTlln?=
 =?utf-8?B?cG5zVG5qMi9VM2ZDV0ZIZWRPYkFqVEpCNGJiRGh3RXNCOUt3SERFVkw0U1lx?=
 =?utf-8?B?SkJBbFNxRElFbXY4SE0yNVRWcUhBU3REZW0yZUtuaVBlOXUvQ3FuMXFWVm9F?=
 =?utf-8?B?Q2ZBN2xITWNnTVBBZ3BxZmxJQ2dHMjhJRDRManlTNUVrUWtLQjlRWVVpSnZy?=
 =?utf-8?B?NzZsNXNlUGQ0MGMrQ0xlRDFRendoRUFpVFJUQ1dDTndSSHcwRzFuNFlmb0xX?=
 =?utf-8?B?Y2VvUEI5NnF6aW9iYnpLNzM3YTNVS3lwY2tXYzN1Q0NpM214cHJVc2F5Uy9Z?=
 =?utf-8?B?Z1Rwa3VCL252aVVhdXFUQlFuY3BaSE1GS09QYjhoZGpDYkllbFZPTjlVUnFo?=
 =?utf-8?B?UURYbk1ZWjdPUWdGRktUK1RjdVNOTDJKVmxCc0JaVkk0VjN0OWY0MGlWK2RW?=
 =?utf-8?B?MGhjT0dTWDdDYSs1RFNiTEV0VmtldVRGdk80MzRFVmpMMWtDZUJlcG1jWTU2?=
 =?utf-8?B?V1R3RXlwVWFud00yVzlyRzNUWFhTeUFxUlFxdUUrTzhxN24zN05wMXhQVVZK?=
 =?utf-8?B?clhWVU5BbEN2RTBIektaNnExOVVWQkFCRXBOdjA2M3JlaDE1WUF5NWtsbGl5?=
 =?utf-8?B?YU92eDJwZ1NzbW1FNFBLWFNQWUdCS3c3bkplam0rSHFSZUdlRUtTTzlrdXJl?=
 =?utf-8?B?dTVuRXgwaDhycForL3VzYmFKN3hFWnY1UjFHc1NsTUxVWDdQRW5KbjdQVHQr?=
 =?utf-8?B?WTJmSHlXQ25FcGJ6Qkc2L3Nndmk0MllVN2draFZTVVIyckpvMlBybThPNEVq?=
 =?utf-8?B?aTJpMHRySklGTmlLUklXZXNUMzV6YnNaeHRmZ1RnemY5b1FkM3lQZzN0TzRN?=
 =?utf-8?B?ZGF3ellBbzNpRklhVUxtYmRyR1JTdUtGQkhNa1VjSkdOVlVDd0RvQjZkalh5?=
 =?utf-8?B?bmduM2ZWR0xBYmJROGNSckhwN0FZVXF3ejJGbEhFZ3ZGNDVla0VPbi9VWVRC?=
 =?utf-8?B?VFJRd25tTy9kVFNEdlpEOS81RFV5TWtUTUk4RGNJTjhJRGxXeUlzZy9UVXdO?=
 =?utf-8?Q?II5XPsBrYShkDSFoGAIHegIrbwqqvvhqOFOWPPvM5JfA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T2RLZ0lXbEcxaCttZVVkeVBQcU1PMG1sOVhpcXlCYmI3cEFzazJPOS9OdTd5?=
 =?utf-8?B?Z1l4NzBnWVQvVjZBcTE5YW1JeTNHY1NjS1BzQ3hUZ3dmbElmV3NLVjFpVThO?=
 =?utf-8?B?MXFwTzBiR1JlMjdsblNtSlAxdGhNblBtSnlzQ1JPTXFSWURxNjR6d1Nwd2g3?=
 =?utf-8?B?aGN4eTRtZWkyUHBuN3A3bjJrUUdBU01BcWFySnFTTlJzVjNqVUxIRU9nYkFI?=
 =?utf-8?B?VzNOSE1kYkdsditwZVZ4RkY3KzdValBKS1BLWnk4Z1FOZFVvUkZpbFcrTXhW?=
 =?utf-8?B?M0s3NDN2Qm1tK0M1bkVkMTZZcCs2bDlMZ2VjWHlhYVRGVldXUHpMaGZwMERH?=
 =?utf-8?B?VEZDbFZURisyZHVLeFAxZzRkV2ZoMkVEbWYvUUhZYjRnU0hoOCt6c00rYzN3?=
 =?utf-8?B?N0ZTMDFhL1cvWUV3TXlrd25qS2lRMzZFUm1kNGF3OWNtY3VuL1kzampmWW9O?=
 =?utf-8?B?Rm5jMlVaSUNaZFVDZEdFdUt4REpsTy9zL21pSHdkdzVkM0hIMlRqTFJoT1po?=
 =?utf-8?B?SWFtOC90M1JqTm5TcTlCQVRXVTJWTWlhMytJc1JpVkVzUFB4ZE1vaUhFRHZ5?=
 =?utf-8?B?YjZ0VFI4ZC8wM2ttb3VFdnRaaWpvRWJGZWxhU3doVEFVOEFxcEozSTBlMkk0?=
 =?utf-8?B?Y09UNUdjMEttYnRZY0h2a2NSSXE3d2E3UFd6U0FHdHRrVDNNeDBPcnlielAv?=
 =?utf-8?B?bUJVK2xWU244R0NBazhMNzY1N2NqYkxBN2s5ZTlwY3Yya0lYN1BPTVFVck1m?=
 =?utf-8?B?eWF4elpBWDg4VzdOaVBxSFhES3J2a1JqMGRHTCtOa296dU5GMkxwaU1GVVVs?=
 =?utf-8?B?MmFmMHBJWHUvdXB3bkdIeWZhYXlXbmJmSVdqVFROaGxCMUlsRlhtV083K09F?=
 =?utf-8?B?UWp4akVydmZzWXd1QWQvWm9rbTVaM1dndFZ5eXNvZGdPRk1LbThTL2N3dVc1?=
 =?utf-8?B?OW5xNmR6NXZMVWMveWwwL3pYeEtRVWZDZFFxa1hCbFRxQndSd0hlcy9sZ1RD?=
 =?utf-8?B?ODU3WTlKVWNUMm9Ic2E2WlNBWjVEaXVkdkI0bk5zOXViZjhWS2pOMGNXRWpC?=
 =?utf-8?B?TmZ1bG1vQ2poM25RN0t4YlBkQk8zb0xyUzZKMkMvdVFsM0t5UDN3dmIwaW5Z?=
 =?utf-8?B?SkFlQ1BFYzV4RUVva2hQRTRjZnczT1JpcThueEtGQlozcEhqT3pDZ24zNkt3?=
 =?utf-8?B?TERHOFI3bkZuaEQyU1NIQWRKbFJqV0JxTHFWOWk3K3dXNmFCdjhPYU9Nb2Vi?=
 =?utf-8?B?c1huM05mZnRHRms1WGZ3bDlzeHhsblpFOUJYb1VFa0RPeGwvUjZYTWtxbWV0?=
 =?utf-8?B?YWp6SU92Z3lhaFRnN2NCVndsMXc4eHg2Qk94anQyam1vdUIzREZpdTNieFMw?=
 =?utf-8?B?cG9SeGw3cEFkRFJVRGRWbkNOb1d4elVCS3lMQTkwTFprMXV4S0RaUDhRdElX?=
 =?utf-8?B?OFVYd2Q3UVlONWVmaXVMUWIxZjlyRkk2dlc3WS80WjJaZkhWZ3BFWG9WY1dV?=
 =?utf-8?B?N3h3VE1oL1hQQWlzNUQ2TGxVdGtWVkZHZk1sRjd1NUV1dy9IK1UxTjY3NXhs?=
 =?utf-8?B?NUthUm01TEtJR0EzRFFBN0ZIZnRYVDdmVTg5M2dPUVJzdVcycEo0QnAwVElL?=
 =?utf-8?B?SEpMNXBYRUYxRjFLRzZYUU1jYStXcUZNbSt1SGpHeHZaVVlQalNyeTNLSVI5?=
 =?utf-8?B?YzB5cm1qcXVIRkhKUGoxam5UTjB2Q2RFRXp1TGI0MHhSbHoveC9UTm4xRlp4?=
 =?utf-8?B?alFmRFZscU8zRk1nS3Q5cnY4b2hYczVhZzVJZVJocWg0Y1RXN25NaEpMcEdK?=
 =?utf-8?B?M1FVRXNzMDJqN0RUTytEQ1lHM3hhVTNlWUw3WmxCaFdoUTN6SnhnbWsvSi9Q?=
 =?utf-8?B?eWZPdUJGVEJyK25RRFdUalpZeUE1K1pNYmlUc2NNTVZiVS94eFdJcGFsRUw2?=
 =?utf-8?B?OGFKby9idlg0QUNlejQvRXFsNnVHalhpOTk2UnhjQTRkaEVwN1pJNHR0aURm?=
 =?utf-8?B?UEV4eHpSWGF4RDVUR2NjaHhFUVI4bXRSUWUvOWFLZU5adm56TVpOdFZCVDE2?=
 =?utf-8?B?ZHZDcDYvUmwzUzFJaUhoTW1PS1NFVFpsSWV4Z1krcDdVL1ZpbXNMcU9sMFRL?=
 =?utf-8?Q?1DXLcfBIoW10zH2N5jfl7C4Wm?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b81e78-bdeb-4512-f34a-08dc7f8d4ad3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 03:13:20.4811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8Bs+9eiW6bsN6sR39gZneCPPL3I8w81IbmxDgMcOTy9d8T6vpADa+/TWuvgrNunImBTUe7DoJwE/QNLKLqW/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7250
X-Proofpoint-ORIG-GUID: O-0dKtZ62rVSGVC8IKtaIatauWf50CZk
X-Proofpoint-GUID: O-0dKtZ62rVSGVC8IKtaIatauWf50CZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 impostorscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290019
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 May 2024 03:13:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/242

--------------SBE5En9gFvFZK5TZdIG40zfx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 44T35jIq000549


On 5/29/24 10:50, Changqing Li wrote:
>
> Hi, Armin
>
> This patch rework Yi's=C2=A0 patch for upgrade scap-security-guide, so=20
> marked as V2.
>
> Add the fix for WORKDIR -> UNPACKDIR.
>
Hi Changqing,


Could you please send a new patch based on the original one? Because the=20
original patch also needs to be backported to scarthgap branch.


Thanks,

Yi

> //Changqing
>
> On 5/28/24 13:44, Changqing Li wrote:
>> From: Changqing Li<changqing.li@windriver.com>
>>
>> ChangeLog:
>> https://github.com/ComplianceAsCode/content/releases/tag/v0.1.73
>>
>> Signed-off-by: Yi Zhao<yi.zhao@windriver.com>
>> Signed-off-by: Changqing Li<changqing.li@windriver.com>
>> ---
>>   ...security-guide_0.1.72.bb  <https://urldefense.com/v3/__http://sec=
urity-guide_0.1.72.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrf=
Ml2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFX5VQ3ULw$>  =3D>sc=
ap-security-guide_0.1.73.bb  <https://urldefense.com/v3/__http://scap-sec=
urity-guide_0.1.73.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrf=
Ml2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFX8DHVmEw$>} | 4 ++=
--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>   rename recipes-compliance/scap-security-guide/{scap-security-guide_0=
.1.72.bb  <https://urldefense.com/v3/__http://scap-security-guide_0.1.72.=
bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKC=
SU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXnOZEZ5Q$>  =3D>scap-security-guide_0=
.1.73.bb  <https://urldefense.com/v3/__http://scap-security-guide_0.1.73.=
bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKC=
SU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFX8DHVmEw$>} (96%)
>>
>> diff --git a/recipes-compliance/scap-security-guide/scap-security-guid=
e_0.1.72.bb  <https://urldefense.com/v3/__http://scap-security-guide_0.1.=
72.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99H=
oKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXnOZEZ5Q$>  b/recipes-compliance/s=
cap-security-guide/scap-security-guide_0.1.73.bb  <https://urldefense.com=
/v3/__http://scap-security-guide_0.1.73.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TER=
KiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOO=
odFX8DHVmEw$>
>> similarity index 96%
>> rename from recipes-compliance/scap-security-guide/scap-security-guide=
_0.1.72.bb  <https://urldefense.com/v3/__http://scap-security-guide_0.1.7=
2.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99Ho=
KCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXnOZEZ5Q$>
>> rename to recipes-compliance/scap-security-guide/scap-security-guide_0=
.1.73.bb  <https://urldefense.com/v3/__http://scap-security-guide_0.1.73.=
bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKC=
SU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFX8DHVmEw$>
>> index 3d739c2..62b1c63 100644
>> --- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.7=
2.bb  <https://urldefense.com/v3/__http://scap-security-guide_0.1.72.bb__=
;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-T=
FBJna6tjXOFUVYPE8hd94kTEFOJOOodFXnOZEZ5Q$>
>> +++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.7=
3.bb  <https://urldefense.com/v3/__http://scap-security-guide_0.1.73.bb__=
;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-T=
FBJna6tjXOFUVYPE8hd94kTEFOJOOodFX8DHVmEw$>
>> @@ -6,7 +6,7 @@ HOME_URL =3D"https://www.open-scap.org/security-polici=
es/scap-security-guide/"
>>   LIC_FILES_CHKSUM =3D"file://LICENSE;md5=3D9bfa86579213cb4c6adaffface=
6b2820"
>>   LICENSE =3D "BSD-3-Clause"
>>  =20
>> -SRCREV =3D "7fb44f78bf33232aad587e87a799afcf576f9b47"
>> +SRCREV =3D "2bf9d43840d3ed36a25262d4f45a4015f9b77d8d"
>>   SRC_URI =3D "git://github.com/ComplianceAsCode/content.git;branch=3D=
stable;protocol=3Dhttps \
>>              file://run_eval.sh  \
>>              file://run-ptest  \
>> @@ -38,7 +38,7 @@ do_configure:prepend () {
>>  =20
>>   do_install:append() {
>>       install -d ${D}${datadir}/openscap
>> -    install  ${WORKDIR}/run_eval.sh  <https://urldefense.com/v3/__htt=
p://run_eval.sh__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjb=
CS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXjOLskRQ$>  ${D}${datadi=
r}/openscap/.
>> +    install  ${UNPACKDIR}/run_eval.sh  <https://urldefense.com/v3/__h=
ttp://run_eval.sh__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2s=
jbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXjOLskRQ$>  ${D}${data=
dir}/openscap/.
>>   }
>>  =20
>>   do_compile_ptest() {
> _._,_._,_
> -----------------------------------------------------------------------=
-
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#240)=20
> <https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-pat=
ches/message/240__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sj=
bCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFUJ_ILlYQ$>=20
> | Reply To Group=20
> <mailto:yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re%3A%20%5=
Byocto-patches%5D%20%5Bmeta-security%5D%5BPATCH%20V2%5D%20scap-security-g=
uide%3A%20upgrade%200.1.72%20-%3E%200.1.73>=20
> | Reply To Sender=20
> <mailto:changqing.li@eng.windriver.com?subject=3DPrivate:%20Re:%20Re%3A=
%20%5Byocto-patches%5D%20%5Bmeta-security%5D%5BPATCH%20V2%5D%20scap-secur=
ity-guide%3A%20upgrade%200.1.72%20-%3E%200.1.73>=20
> | Mute This Topic=20
> <https://urldefense.com/v3/__https://lists.yoctoproject.org/mt/10634402=
6/7283133__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHt=
x99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFW8NmEOrw$>=20
> | New Topic=20
> <https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-pat=
ches/post__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHt=
x99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXVb7cNpA$>=20
>
> Your Subscription=20
> <https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-pat=
ches/editsub/7283133__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfM=
l2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXJwNrTDQ$>=20
> | Contact Group Owner=20
> <mailto:yocto-patches+owner@lists.yoctoproject.org> | Unsubscribe=20
> <https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-pat=
ches/leave/13170635/7283133/1683771902/xyzzy__;!!AjveYdw8EvQ!Y8jCzWkFy25T=
ERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJ=
OOodFUABJIxVg$>=20
> [yi.zhao@eng.windriver.com]
>
> _._,_._,_
--------------SBE5En9gFvFZK5TZdIG40zfx
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/29/24 10:50, Changqing Li wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:bb06fd56-1a73-42d7-b6d7-98032d57e5b4@windriver.com">
      
      <p>Hi, Armin</p>
      <p>This patch rework Yi's&nbsp; patch for upgrade scap-security-guide,
        so marked as V2.&nbsp;</p>
      <p>Add the fix for <span style="white-space: pre-wrap">WORKDIR -&gt; </span><span style="white-space: pre-wrap">UNPACKDIR.</span></p>
    </blockquote>
    <p>Hi Changqing,</p>
    <p><br>
    </p>
    Could you please send a new patch based on the original one? Because
    the original patch also needs to be backported to scarthgap branch.
    <p><br>
    </p>
    <p>Thanks,</p>
    <p>Yi<br>
    </p>
    <blockquote type="cite" cite="mid:bb06fd56-1a73-42d7-b6d7-98032d57e5b4@windriver.com">
      <p><span style="white-space: pre-wrap">//Changqing
</span></p>
      <div class="moz-cite-prefix">On 5/28/24 13:44, Changqing Li wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:17D390C542482B45.24533@lists.yoctoproject.org">
        <pre class="moz-quote-pre" wrap="">From: Changqing Li <a class="moz-txt-link-rfc2396E" href="mailto:changqing.li@windriver.com" moz-do-not-send="true">&lt;changqing.li@windriver.com&gt;</a>

ChangeLog:
<a class="moz-txt-link-freetext" href="https://urldefense.com/v3/__https://github.com/ComplianceAsCode/content/releases/tag/v0.1.73__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFWyB6fRrQ$" moz-do-not-send="true">https://github.com/ComplianceAsCode/content/releases/tag/v0.1.73</a>

Signed-off-by: Yi Zhao <a class="moz-txt-link-rfc2396E" href="mailto:yi.zhao@windriver.com" moz-do-not-send="true">&lt;yi.zhao@windriver.com&gt;</a>
Signed-off-by: Changqing Li <a class="moz-txt-link-rfc2396E" href="mailto:changqing.li@windriver.com" moz-do-not-send="true">&lt;changqing.li@windriver.com&gt;</a>
---
 ...<a href="https://urldefense.com/v3/__http://security-guide_0.1.72.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFX5VQ3ULw$" moz-do-not-send="true">security-guide_0.1.72.bb</a> =&gt; <a href="https://urldefense.com/v3/__http://scap-security-guide_0.1.73.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFX8DHVmEw$" moz-do-not-send="true">scap-security-guide_0.1.73.bb</a>} | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename recipes-compliance/scap-security-guide/{<a href="https://urldefense.com/v3/__http://scap-security-guide_0.1.72.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXnOZEZ5Q$" moz-do-not-send="true">scap-security-guide_0.1.72.bb</a> =&gt; <a href="https://urldefense.com/v3/__http://scap-security-guide_0.1.73.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFX8DHVmEw$" moz-do-not-send="true">scap-security-guide_0.1.73.bb</a>} (96%)

diff --git a/recipes-compliance/scap-security-guide/<a href="https://urldefense.com/v3/__http://scap-security-guide_0.1.72.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXnOZEZ5Q$" moz-do-not-send="true">scap-security-guide_0.1.72.bb</a> b/recipes-compliance/scap-security-guide/<a href="https://urldefense.com/v3/__http://scap-security-guide_0.1.73.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFX8DHVmEw$" moz-do-not-send="true">scap-security-guide_0.1.73.bb</a>
similarity index 96%
rename from recipes-compliance/scap-security-guide/<a href="https://urldefense.com/v3/__http://scap-security-guide_0.1.72.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXnOZEZ5Q$" moz-do-not-send="true">scap-security-guide_0.1.72.bb</a>
rename to recipes-compliance/scap-security-guide/<a href="https://urldefense.com/v3/__http://scap-security-guide_0.1.73.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFX8DHVmEw$" moz-do-not-send="true">scap-security-guide_0.1.73.bb</a>
index 3d739c2..62b1c63 100644
--- a/recipes-compliance/scap-security-guide/<a href="https://urldefense.com/v3/__http://scap-security-guide_0.1.72.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXnOZEZ5Q$" moz-do-not-send="true">scap-security-guide_0.1.72.bb</a>
+++ b/recipes-compliance/scap-security-guide/<a href="https://urldefense.com/v3/__http://scap-security-guide_0.1.73.bb__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFX8DHVmEw$" moz-do-not-send="true">scap-security-guide_0.1.73.bb</a>
@@ -6,7 +6,7 @@ HOME_URL = <a class="moz-txt-link-rfc2396E" href="https://urldefense.com/v3/__https://www.open-scap.org/security-policies/scap-security-guide/__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFVDVhZOoA$" moz-do-not-send="true">&quot;https://www.open-scap.org/security-policies/scap-security-guide/&quot;</a>
 LIC_FILES_CHKSUM = <a class="moz-txt-link-rfc2396E" href="file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820" moz-do-not-send="true">&quot;file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820&quot;</a>
 LICENSE = &quot;BSD-3-Clause&quot;
 
-SRCREV = &quot;7fb44f78bf33232aad587e87a799afcf576f9b47&quot;
+SRCREV = &quot;2bf9d43840d3ed36a25262d4f45a4015f9b77d8d&quot;
 SRC_URI = &quot;git://github.com/ComplianceAsCode/content.git;branch=stable;protocol=https \
            <a class="moz-txt-link-freetext" href="file://run_eval.sh" moz-do-not-send="true">file://run_eval.sh</a> \
            <a class="moz-txt-link-freetext" href="file://run-ptest" moz-do-not-send="true">file://run-ptest</a> \
@@ -38,7 +38,7 @@ do_configure:prepend () {
 
 do_install:append() {
     install -d ${D}${datadir}/openscap
-    install  ${WORKDIR}/<a href="https://urldefense.com/v3/__http://run_eval.sh__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXjOLskRQ$" moz-do-not-send="true">run_eval.sh</a> ${D}${datadir}/openscap/.
+    install  ${UNPACKDIR}/<a href="https://urldefense.com/v3/__http://run_eval.sh__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXjOLskRQ$" moz-do-not-send="true">run_eval.sh</a> ${D}${datadir}/openscap/.
 }
 
 do_compile_ptest() {
</pre>
      </blockquote>
      <div width="1" style="color:white;clear:both">_._,_._,_</div>
      <hr>
      Links:
      <p> You receive all messages sent to this group. </p>
      <p>
        <a target="_blank" href="https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-patches/message/240__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFUJ_ILlYQ$" moz-do-not-send="true">View/Reply Online (#240)</a> | <a target="_blank" href="mailto:yocto-patches@lists.yoctoproject.org?subject=Re:%20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-security%5D%5BPATCH%20V2%5D%20scap-security-guide%3A%20upgrade%200.1.72%20-%3E%200.1.73" moz-do-not-send="true">Reply To Group</a> | <a target="_blank" href="mailto:changqing.li@eng.windriver.com?subject=Private:%20Re:%20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-security%5D%5BPATCH%20V2%5D%20scap-security-guide%3A%20upgrade%200.1.72%20-%3E%200.1.73" moz-do-not-send="true">Reply To Sender</a> | <a target="_blank" href="https://urldefense.com/v3/__https://lists.yoctoproject.org/mt/106344026/7283133__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFW8NmEOrw$" moz-do-not-send="true">Mute This Topic</a>
        | <a href="https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-patches/post__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXVb7cNpA$" moz-do-not-send="true">New Topic</a>
        <br>
        <a href="https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-patches/editsub/7283133__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFXJwNrTDQ$" moz-do-not-send="true">Your Subscription</a> |
        <a href="mailto:yocto-patches+owner@lists.yoctoproject.org" moz-do-not-send="true">Contact Group Owner</a> |
        <a href="https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-patches/leave/13170635/7283133/1683771902/xyzzy__;!!AjveYdw8EvQ!Y8jCzWkFy25TERKiQ-GH2SFtkZJmu1WHsrfMl2sjbCS4XHtx99HoKCSU-TFBJna6tjXOFUVYPE8hd94kTEFOJOOodFUABJIxVg$" moz-do-not-send="true">Unsubscribe</a>
        [<a class="moz-txt-link-abbreviated" href="mailto:yi.zhao@eng.windriver.com">yi.zhao@eng.windriver.com</a>]<br>
      </p>
      <div width="1" style="color:white;clear:both">_._,_._,_</div>
    </blockquote>
  </body>
</html>

--------------SBE5En9gFvFZK5TZdIG40zfx--

