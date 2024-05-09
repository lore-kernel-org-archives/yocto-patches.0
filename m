Return-Path: <mingli.yu@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53452C10F1A
	for <webhook@archiver.kernel.org>; Thu,  9 May 2024 05:40:58 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.3410.1715233251908372254
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 May 2024 22:40:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5859e85daf=mingli.yu@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4495Ud3t021935;
	Wed, 8 May 2024 22:39:50 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xyse1hfvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 22:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1HMDQkdalu6ahA7E2FiBOXVP3YaG2h1Oq81rNXsFnjfMnzlRkc9nU/xPdZLy2agwOZOXjdme5+h5KJ5gyWK07DulUd/QFq5israwbbMmvHXvmjCGTxzdvTdBvARF68qXuVVvRequ4H696GOaTWA0M0iaGxlG4J+X6/mFbM3XD9R1KxfOAOd0qHJIZY5t0iFxeBWxU2JsVzImqFVVvMAJQPr8GXkb7u205EcS6KYwaiy+/XKtPVUjVTv99P3dEJTcCrK7YLCdoEYn2gUe92KA3QcMpHAyMfjuxqxxWy+Jk9+4WbgzCWZzOqEgxWDofNJi9eZZOk07z9utDWmAj9nBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSZd8/m47zf1mEGRazn7AxDHfH+c5qCidf45BsIAbNs=;
 b=CoDA0cOGnPgSohIjzjhQ/a/gsRRbPfZDotUfmV8XDlMaWr8Oyv3Xr1zPzxKXYX8arP+YUYZXuPxv6rnRyJXT7DIx3Vi9GwP4Sk1N0xQpFAl8ZVwuOxugdQ0wcdFx49Kt1XQGRBOk1g4Lyy3VjipPNDxNJmY9wxJxMsVOAVVuhBysIMVt9i/CdnzlulIs/iCD0UHf223quJlJVfeUnofbhP1pQhcPOj9N/wlSAgiF+Tg74Khaj7yJmQ56O4hAcv6FxLPTIfOGS2W7/jm92nGO7Z/OD27Nd0vAuorm9AFaRKidToEC8iH3lKUP5uib0o4XSx9EELFxIrwyX1i79LbQ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB5009.namprd11.prod.outlook.com (2603:10b6:303:9e::11)
 by SN7PR11MB7509.namprd11.prod.outlook.com (2603:10b6:806:346::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 05:39:39 +0000
Received: from CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::b792:3207:f838:98a1]) by CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::b792:3207:f838:98a1%4]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 05:39:38 +0000
Message-ID: <41fdcf95-8db0-44af-b7a4-56e9ec078f00@windriver.com>
Date: Thu, 9 May 2024 13:39:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [yocto-kernel-cache][PATCH] preempt-rt: add bfp
 configs by default
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org,
        Bruce Ashfield <bruce.ashfield@gmail.com>
Cc: Kevin Hao <kexin.hao@windriver.com>, "He, Zhe" <zhe.he@windriver.com>
References: <20240508070412.2939015-1-mingli.yu@windriver.com>
 <Zju3bQe0KEoRZcpH@gmail.com>
 <7aedf47d-3c8b-4627-b533-3cff6ceacc77@windriver.com>
 <CADkTA4P4vuunbmNc8O712pD9=uR=fDFcXwuwG129vd0yF-4VoQ@mail.gmail.com>
From: "Yu, Mingli" <mingli.yu@windriver.com>
In-Reply-To: <CADkTA4P4vuunbmNc8O712pD9=uR=fDFcXwuwG129vd0yF-4VoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To CO1PR11MB5009.namprd11.prod.outlook.com
 (2603:10b6:303:9e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5009:EE_|SN7PR11MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de208b0-965c-4022-ee35-08dc6fea6ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QVp4cUZxYlNuUTFUa0p6NVNITDBzZ0MwK2hHQUNxQUF3dklJRHcrRTlZOW5S?=
 =?utf-8?B?UjdJNVlTTXc3Q1NUM2FWSGZDTDhFdDJFQWpwdjRQeHJUTUtNdWVaamhjQlps?=
 =?utf-8?B?UHhOZWpvSXhyR01uMDdIY0RlSHJuR2lJRGgwZUJ6d0dFZ0pxWTIxV1VzMUE2?=
 =?utf-8?B?bVBhakpJZHpBQ25MMEwrRDJrekRXeGI0b1M2L3NaSFc5eHkvaEp3NDh2a1dy?=
 =?utf-8?B?b2NPQ1RTQlN4R1dEZDFyWU9aREVBQnkvK3F4cWhVSE9XWDVSWmhGc1RqdCtZ?=
 =?utf-8?B?WjBaTy94Z0o0SFIxVU93V1g3dUR0Yjd4RUYzMER3MGtwdlBJS1dhT1lnNW5a?=
 =?utf-8?B?RDlveGJnWjFJanRPSGFPaVBEMG5WMC9tUVRVcFBsc01FYWkrSmY3eG5peDVt?=
 =?utf-8?B?MlJpZHhrSFIwQkU4eUJMc0N2akt4cXJ4dHl3KzZ1QWtiSXlzUzJFNnF5eTk5?=
 =?utf-8?B?VDFJblAyS3FrTFkveDV3VzVmS1ZDQkd5c2V2aTBpVXZxMzFFTmdlOE9XM0Vo?=
 =?utf-8?B?MFlxbjB6MTR1MGtubWJITVVUUU1TNGE0OTdFWnRra1E5RndQVlFaK1VCaG1v?=
 =?utf-8?B?blpNbjFlZjVFdHBDZlU1TkVPY1N4ekJyekVrNFVpcVkxYWhLWXo2cWJQazJw?=
 =?utf-8?B?K2s0WWgzUThGd1laeEU5QnVZNjUwMWpOOTBTR1JCWGRrL0orSzk4MStBc21k?=
 =?utf-8?B?ZCtKWFlLejcwRmlDZ0taa1lEUWJwTzRFWjlVM3ltZnM5WVJkWTExeXpOVkxM?=
 =?utf-8?B?Z3hUa0IzSzdNTllocFRCZUFueDNFeU1zWVpKWUxKcnBMVXUyTnBlUDJhR3Jp?=
 =?utf-8?B?WUt5clpTMnpKM0FHVEN2ZGgwTVVjM0RRbzJ1Mjg3QjZEbU00OXg4T2tWTXFS?=
 =?utf-8?B?d212bmhldmdUWGtaSWJFWU5yNHV3dTE2bVNyT25hV3lUaUVPbDBPUnM3SGdl?=
 =?utf-8?B?U2t6L21tbnNlUEZ4cmN3VE80bmk2TVNLTGR3VkFMUTQ1K1V5MVpRa1ZLSjJC?=
 =?utf-8?B?bWF0V3R3Uk52WHdHZ05URTFRTUlLRTJoZHNyTzk5VVhNL1FrNHFMYjBHbXBS?=
 =?utf-8?B?em0rZVg1aVJ3T3FYVU0vbGdZU3pzb01YK0ZKUTVsdGh4aVcvZDZPNFliTUVj?=
 =?utf-8?B?NXBUVlYzWG8wcWFrcDNwd3pXeXZ6TGJjSEVqN05sMVFPZHZybmJKZXovUSt0?=
 =?utf-8?B?eU9wV2c0amtxNFhXSkRYRmZuOUxTTlUzZmZrbERPSzdCNUl1c1JTMi9zT0Zz?=
 =?utf-8?B?UXJjL2dRVklZUFdJdnZsVFpkK3pBNEViZjFQOTBNT0syaUxpZmNRQm50Sisv?=
 =?utf-8?B?UmFsbjBuOXhrMGJ6aU5qdUdGOXJJNzl2Wm5NYmV0dW5BOW1BWXhJN2ZUT1ZC?=
 =?utf-8?B?Y0ppYkQ0aUNKeCtGTDFTVFhENTk0MGFNRFhyMEJ0OEtKNUNab2xFTFQzVXpE?=
 =?utf-8?B?aXdBQmdHOWJqYmJ4K1VLWGladVpNWG05NGlTNUpIUnJRY24xeFdaT3BqU3FY?=
 =?utf-8?B?Tno2dXFXVERoaUdkbGxHbkVVa2tRcnNsU0FOdHFMaHJwNDhBOGluSWw2RkVp?=
 =?utf-8?B?dEt0MHhLdDhiZysvemtOR2dtVWQyUTRoYjQ5YzN1d2VPYzlhY3Jkamk2R1ps?=
 =?utf-8?B?VG5aamZUNDhrNGpZK0F5N2pjK09ERXc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5009.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z2QvcjJuQ2MyN0h6SkVoR2c1N0NoaTZQU3VEYTFOWFNCQWt3VDVKR0FCcXRJ?=
 =?utf-8?B?WUYyL2FCZWNpZC8raHVSSHhKSUd6M2kvQ0JvaDRLVlMzZ2ZkcStFcE1ySTEz?=
 =?utf-8?B?YmJGR1FiK2NUN2J2cEt1NllaamhlQS8vSnhnemtIeUsrM3BZYmJEMHBzU25m?=
 =?utf-8?B?dzh3RGc0OVREVEZZVlRpQ1pZMjhwTnY2WTZXYU50U2RJd0NsSTVteERGbHEr?=
 =?utf-8?B?WHJyT05zMUZ2ZnlUNVZCZ2FqaFR4Q2IyMzRidllNZTVQdldVWVY3MnRSZjFZ?=
 =?utf-8?B?dmtsakFpR21TR2RyOVJPUW5mZ2FlL2FWazdoaGdTUUdEK3Exb3plemI5WFJy?=
 =?utf-8?B?dHlzV2U1RThraUNOa3AwRThSMm1hTkorRmV1NmJma3BjQllleGJSSXg0NEho?=
 =?utf-8?B?blA1N253bFdRd3lZejhxcXpkc0RDTm1MTmRrS1M3eDMwOTljUlBFYXlHS3JU?=
 =?utf-8?B?d0lER3lJb0cyU1NuVGhwdk81STJ2cWhZRGlrcWUzNThpclVpVlBlaTNlWEtw?=
 =?utf-8?B?Vkl5aUJGaUs4VjVzTFRGeWsyWndKSzloYmR3SW9QTjh3N0RRb0dlUVdSRitH?=
 =?utf-8?B?emV5Ti9rWXFIaUFZb3VxRFlPaytyQkFCK2xEMGxIQktXQVJVeUlGU2gzSito?=
 =?utf-8?B?cnNPN1BLbVlDa240NFJVR3BvdUFIYzRyWkIwc2puRS9xbUd2TkEwcE85aGd0?=
 =?utf-8?B?QTF5V1A4NjNYYU0wKzZkMWxIbnFwdnpBc1dTOWRtTlYyYXZhY2hTd3pyOXZG?=
 =?utf-8?B?di9xUWtaK3hOUWZGeTd0bTFBRzRYZDZKcjdhU0FXNlRDc2pFcnFOczFpUlFa?=
 =?utf-8?B?SXNvS3UvbkZWZGNMTml6VG94R09tdTFhaGJGTTFvSEF2QTJaUmFTcDEyLzNJ?=
 =?utf-8?B?OU1jYjFDYWdQYWY2amxJWm1QdDhGZm5HdVRrMlpqVlhGaUpjK3cwc252VDIr?=
 =?utf-8?B?eTZCZHFTNWJSUDJSeVBwQy8xd3k4ZENHQkw0K01KVTk4Rloxam1SRGJjQjhS?=
 =?utf-8?B?K3NmdHdrS1Z6YlJjL1lnMmdCMXM3UlJTMlp3M0lGVWRhL1lBQmtZNWxxN1dl?=
 =?utf-8?B?L2JMak4vWXN4UUpKeUIwUmhLcHEyUDIxYjdaQmZpQ0lCN3ZMTmR4a1M2RnYx?=
 =?utf-8?B?NUtyZy91VjVRcllISE1VVEp2cTcxMWJmbVUveTVUUUxWdmwyVEdYb3VwUFVk?=
 =?utf-8?B?L3Z5WE1adTZlY3crVzNGZElQSDdMek5FYk9uclRlckp2cUdSMW5hUStub2VJ?=
 =?utf-8?B?RkVOeXJ3VXUyZysrWjM3cVZIaFVyREVaZ3NweVRoQnJrcVFNS1JUTUlqRzg5?=
 =?utf-8?B?L2hIMXEyemxwMk0rQWVqSjVudnhmT2dzU1p2ZmEwbFZHVm55WHVFWXphRnRZ?=
 =?utf-8?B?MDRJbjJTcWVGRWx1cEh6WFZ2TlU5QXpIa0U4MWxLZWpTOTBGcFVpdUgxUHJQ?=
 =?utf-8?B?Ry9qRlpBTnFZQmR2Si9kemswR000M0NWK2hISkJIdHM2cU92L0ZaY1prSmY5?=
 =?utf-8?B?NUs3NWYvdjdOanQyUml5U0pUYkJNZFdTcFNqZWJCazZ5eFp2SlBJcDN0Qjgz?=
 =?utf-8?B?c3hsODhhZFF1UEQ4c0JiaGxCa0RVZFhkZ0FBNW0vaGUvdncvcHlIeXE1TXkz?=
 =?utf-8?B?MGpTSFVxeEJMckZNYTdoMkJWYjA3bW9Ub1I1VFZGTHlhb1dmTGM4VTk2WVlG?=
 =?utf-8?B?dm1Sd3JMUGQzSzFGYVYxdWJXa2ljZldUTVZudDBIdEk5bWVTenRCbFFhV2lS?=
 =?utf-8?B?bW1GWGtVY1h1b0t5VldtMXRZTVVCMW1BZVpOTFZrdytSN0RGV1pqeWE5S2ZM?=
 =?utf-8?B?N3ZJTUwvd25IdUZueWtlNm9iNVFQUmtFMGxIUnZuOGZQMVRsbDhHdE1YNE1l?=
 =?utf-8?B?eHdQSlZZVWhiQ3NqNSsvVUlZcTRkczJ0WFAvQUN0ZVRuWjd1K1BWQ1VQYkZu?=
 =?utf-8?B?TTdPc3lsZ1NVRVR2R2Z2NEdGVS9CcmVTQkxqTjlLQ3pBeFpGaFJoNDYwa2FO?=
 =?utf-8?B?WHRGeWMvSjZkdVk4N3RiSjNsV1NaT0tTejU1ZjdEUjlCTmxTZExNNkJmZ0RI?=
 =?utf-8?B?V0QxOHIzdmZtS2VxZzBMYVMrUURUd3IrbEl5YmpkempzUTVBTmVyd2J5bUNx?=
 =?utf-8?Q?TSrJnDvwfF9bCitSkoWPkZzVn?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de208b0-965c-4022-ee35-08dc6fea6ac9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 05:39:38.7341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CuKWhUoqDnCRS5CI+3KmH4kvcsvjrdHR6QUfvfPovrjtTsCbJH+yXFKtxOg/MeIwU9q3LGUc9yJPGxeSro7niQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7509
X-Proofpoint-GUID: 5P_H8T6Ur8BSGXnNj27amnzD7le_Xwic
X-Proofpoint-ORIG-GUID: 5P_H8T6Ur8BSGXnNj27amnzD7le_Xwic
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_02,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405090036
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 4495Ud3t021935
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 May 2024 05:40:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/110



On 5/9/24 11:22, Bruce Ashfield wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
>=20
> On Wed, May 8, 2024 at 10:14=E2=80=AFPM Yu, Mingli via lists.yoctoproje=
ct.org
> <mingli.yu=3Deng.windriver.com@lists.yoctoproject.org> wrote:
>>
>>
>>
>> On 5/9/24 01:33, Bruce Ashfield wrote:
>>> CAUTION: This email comes from a non Wind River email account!
>>> Do not click links or open attachments unless you recognize the sende=
r and know the content is safe.
>>>
>>> In message: [yocto-patches] [yocto-kernel-cache][PATCH] preempt-rt: a=
dd bfp configs by default
>>> on 08/05/2024 Yu, Mingli via lists.yoctoproject.org wrote:
>>>
>>>> From: Mingli Yu <mingli.yu@windriver.com>
>>>>
>>>> Userspace functionality that requires BPF is becoming more common,
>>>> so enable it by default [1].
>>>
>>> bpf used to have locking issues with preempt-rt, which is
>>> why it isn't already enabled.
>>>
>>> Can you show some logs for your testing that has happened
>>> with BPF enabled -rt so that we can document what has been
>>> done to prove it works now.
>>
>> When CONFIG_BPF_SYSCALL is't enabled, there comes below failure with r=
t
>> kernel.
>>    # docker run hello-world
>> Unable to find image 'hello-world:latest' locally
>> latest: Pulling from library/hello-world
>> c1ec31eb5944: Already exists
>> Digest:
>> sha256:a26bff933ddc26d5cdf7faa98b4ae1e3ec20c4985e6f87ac0973052224d2430=
2
>> Status: Downloaded newer image for hello-world:latest
>> docker: Error response from daemon: failed to create task for containe=
r:
>> failed to create shim task: OCI runtime create failed: runc create
>> failed: unable to start container process: error during container init=
:
>> error setting cgroup config for procHooks process:
>> bpf_prog_query(BPF_CGROUP_DEVICE) failed: function not implemented: un=
known.
>> ERRO[0059] error waiting for container: context canceled
>>
>> And the above issue is resolved once CONFIG_BPF_SYSCALL enabled.
>=20
> Being able to run docker on preempt-rt isn't a use case that I
> consider high priority. Not that it is a bad use case it is that if we =
want
> -rt to have any value, we actually need to show that realtime behaviour
> is preserved as we enable more options and run different workloads.
>=20
> Getting docker to pull an image doesn't prove/show that -rt and BPF
> aren't going to spike latencies, or cause other issues.
>=20
> BPF used to cause locking issues and other latency issues.
>=20
> There are BPF self tests, showing that they run and pass is a good
> first step.
>=20
> Then also running the latency measurements while running both
> BPF tests and pulling, deleting, pulling, running, etc, containers is
> the second thing we need to show. If there aren't any latency
> spikes or locking traces we can consider it "safe enough" to enable
> for -rt.

Thanks Bruce for your clarification!

I'm not familiar with BPF tests, so can't provide the test results right=20
now. I'm okay with your concerns.

Thanks,

>=20
> Bruce
>=20
>>
>> Thanks,
>>
>>>
>>> Bruce
>>>
>>>>
>>>> [1] https://lore.kernel.org/all/20200224140131.461979697@linutronix.=
de/
>>>>
>>>> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
>>>> ---
>>>>    ktypes/preempt-rt/preempt-rt.scc | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/ktypes/preempt-rt/preempt-rt.scc b/ktypes/preempt-rt/pr=
eempt-rt.scc
>>>> index 7ff7c0a8..a5e345f9 100644
>>>> --- a/ktypes/preempt-rt/preempt-rt.scc
>>>> +++ b/ktypes/preempt-rt/preempt-rt.scc
>>>> @@ -39,3 +39,4 @@ include backports/backports.scc
>>>>    include features/rt/rt.scc
>>>>
>>>>    kconf non-hardware preempt-rt.cfg
>>>> +include features/bpf/bpf.scc
>>>> --
>>>> 2.25.1
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>
>>>
>>>
>>>
>>>
>>
>>
>>
>>
>>
>=20
>=20
> --
> - Thou shalt not follow the NULL pointer, for chaos and madness await
> thee at its end
> - "Use the force Harry" - Gandalf, Star Trek II
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#108): https://lists.yoctoproject.org/g/yocto-patche=
s/message/108
> Mute This Topic: https://lists.yoctoproject.org/mt/105976633/3618448
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13176=
015/3618448/1484545583/xyzzy [mingli.yu@eng.windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20
>=20

