Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE41CA1007
	for <webhook@archiver.kernel.org>; Wed,  3 Sep 2025 00:28:07 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.849.1756859285050629426
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Sep 2025 17:28:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=o3qywFHm;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=134114aca2=randy.macleod@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5826vWE01223092;
	Wed, 3 Sep 2025 00:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PPS06212021; bh=NIDzEO4zmXeaVFdFJ+WiMr
	Cka1idEOrYxUWVgbNhvdA=; b=o3qywFHm50+Aa+qjPc8W6FVcSJ3/wIARvtuUHV
	WOWHJeNEGlfGMuXq+hvICIJA31KWLV/K/6muzKaxpWRQiYGXjGoEhhqnTe7QmTBS
	PzaRdualem6byCVcj70xi+xmUJVQGVQS+G2/GQ4DebqCyz7fnLVk3rG3rRmNEixx
	ZZoryza2mjd+PLfb6D8hPmZ3SIOfFlXRsI9gYw/JqShS/Sm497JEYJNjVZnuqtoE
	yXL7oExDwzI9hFRzRl9nXHfczr6rgjw9eNBIwLXPUxphl1IRyLlUOAYT+OFUexuF
	4/xhtnayUQHQe7gj6Nwiiw2wLBCmSmdc817UA00aZm/70W4w==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48ur99udq6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 00:28:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3Mh2jefdVS9kbI5CFR9irsUHlkUS0Axx4X8NkKCx7cnNtA0SXBYjDn/G+VfH8CdgJj0biJVaYnzeTbLRH9ilBZOXjMkaz372hcYDL2BiyDd+SqsOHkWKcShRxFJZV26zjkFrKzeUTpgGtw7k5OW0zx3pylkgCOsK5Y7E90Q4hzr+jhRY7X/3EGZg7MvBzCYDM59kD9z+qsC/3sC3IJEJUCFwZU2gx9HvKN7qf/+kV8DmIg8xhhugJB5PLCOUGWyWde7ohUCWWA1RcdPe05aU0e7mP7TlpxUXoM7v7SlxS4KbMr84AqmVoJl74S19u55w2jwzRRzn93stkSBAvxRyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIDzEO4zmXeaVFdFJ+WiMrCka1idEOrYxUWVgbNhvdA=;
 b=sggxjwxUTBmKXH307Qi19pBHABY8ocbv7C7RGQ6l43IKqnF9hatwN0s3UNBHNVuBYg3TszvSwVmp75jpanRXmeun9BcAqabzP+8vLM5PQYukUixLCs/v6ZttI5hCKY34fBmB3QPMs1FbGjg8PyAn1DajUDot5ueM4Kaif0zN+2LcMNHWAZsFZENL1azsrjAEGRG2WZgocWJLY7tAiqk3Y5sBmhwg8AkjVJ6XWjm7FT9HN4bUeetal6eTP2W5fiS3KqXsu8H9QchD0osorlZV8k/Rq20qAD3CfsdN18nbVxNDlb5uewF14sYv0OPu51eeFECdfvXg1beQNMNwLQ3Xig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8496.namprd11.prod.outlook.com (2603:10b6:610:1ba::22)
 by DS0PR11MB6469.namprd11.prod.outlook.com (2603:10b6:8:c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Wed, 3 Sep
 2025 00:28:00 +0000
Received: from CH3PR11MB8496.namprd11.prod.outlook.com
 ([fe80::cdc3:a646:2a93:9552]) by CH3PR11MB8496.namprd11.prod.outlook.com
 ([fe80::cdc3:a646:2a93:9552%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 00:28:00 +0000
Content-Type: multipart/alternative;
 boundary="------------q0ymE9lKPTmsQZxYfBTFzASA"
Message-ID: <271bcd7c-3047-4eac-8e34-13f5f42c7163@windriver.com>
Date: Tue, 2 Sep 2025 20:27:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Insights from Integrating mixins rust into kirkstone-based
To: Scott Murray <scott.murray@konsulko.com>,
        "Sambu, Soumya" <Soumya.Sambu@windriver.com>
Cc: "yocto-patches@lists.yoctoproject.org"
 <yocto-patches@lists.yoctoproject.org>
References: <CY8PR11MB7921AAF6CFDC45DD76C7B40B813BA@CY8PR11MB7921.namprd11.prod.outlook.com>
 <3f3df632-63bd-652b-dba6-4a4a3a6a0f93@konsulko.com>
Content-Language: en-CA
From: Randy MacLeod <randy.macleod@windriver.com>
In-Reply-To: <3f3df632-63bd-652b-dba6-4a4a3a6a0f93@konsulko.com>
X-ClientProxiedBy: FR4P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::12) To CH3PR11MB8496.namprd11.prod.outlook.com
 (2603:10b6:610:1ba::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8496:EE_|DS0PR11MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 00cc6058-643c-48db-3b63-08ddea80bcbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RW1vWnJZQndqUTlzS1F6U2w0dFdpTG96aHc5T2crSDgycFhRNFZMS0xHSnNS?=
 =?utf-8?B?bUhjcU9BS21DRWdkbnRpaS9SdW1XNldHd2o0K0kxWGhZa1doYndVeWFja2p6?=
 =?utf-8?B?dWcvY3VvdTkyUGpkQUJzREdESWd3UWZFazN1cVZTUm5pU1lBYXh4WjBJdW1l?=
 =?utf-8?B?d3RRNnA4RFdiVzBXZ0N5T0JVL0lldSt1ckdvNFZKYTZGOVk2bjFtNmRqbC9E?=
 =?utf-8?B?K2xsV04rQ1ZRVGF3NGx6YWh0ZGRlVWpvTm5HQVo0YW1OVWtYSEVjb2cxUXAw?=
 =?utf-8?B?T1FrUkorcENqQ29FK2ZRODBoQ2YxVjM4WkR3ZnpBdnhOOVkyQlJPTThPQjNE?=
 =?utf-8?B?aXZncHRSYzdKMVIrT0llTkFQeHNIM0lUdis0aFNnS0dWbzBLZmEvNmk2dzha?=
 =?utf-8?B?bnIxcVgremJidmJyUDZyNXlJMndyYjJxaEdJNUd4YUlwZmJkMkdlS1BLbHlw?=
 =?utf-8?B?UzJmM2NUYldQN3E3Y2ttbUFLVDJFOHhFeG90aUxjR0Y5ckhScXBYYW4wcXhv?=
 =?utf-8?B?cTFVRUlDUisrb2h6NklTTzlqdHlRWXhiWVdWdlljdkpzdEY2cGhKNGV1dlpR?=
 =?utf-8?B?SENWbWptWFgweWllc3UwL0tUSmdxY0tnMkQvalg2NTBaVkhwUWRVRVZYZVNH?=
 =?utf-8?B?Umh1SHlqTkZzRXhyMHgxNmkwY2Q3cHp5bERpVDBZQUExN0IvUDh3MThTR0hC?=
 =?utf-8?B?Wnc4a2tiWDNEaEZmZTlOVi9Nb1ZZdzgrNjRNVE5ZTGhWcmRSOWdGNUpadnBn?=
 =?utf-8?B?MXY3K2FDWk1JellWQW4ycXpuTGdkWFRlcEJ1TXNFc1lXWFRLWU1HK2tDenpN?=
 =?utf-8?B?VTI5TFhRaWJkNXUzTEJpTTMvaTJOa0NKeUR1MkF4T0kyWFp6TzVaRHJ1TUk3?=
 =?utf-8?B?ZmhiZ01GUlREaEdDL3VwRlgvdXpRYUxya1BiTk9jaXdQV1hNSWNKNCs5RFpS?=
 =?utf-8?B?NzB6YU1PMktkY2F0SzhuUUFNUE00c2oxZTVyaDIyd21POER3b2NGbGZneXlP?=
 =?utf-8?B?Y3pPS1hlSlRVejg1Y1djL0FYUEIyYUhuV1ZGam1iSzBjeGh6STRGdm0ycWxT?=
 =?utf-8?B?ZVNGUGZHMEYrTVR4cXpiRmt5cGxOdG1tV0ZOTkFveFNUMHdkR2xXanhVTysy?=
 =?utf-8?B?ZGh2dkhIRHFvcnNMenYrZk05Q1F6WEQ3UjdheUpJenRKNjJGMjdIV1p5VUtP?=
 =?utf-8?B?Tk9Na05xYkM3QjlYV21YWG14aTFxaFRsZkFaWFlGWm9oMG5wV3l2WEZLRmUx?=
 =?utf-8?B?SlZ6ZUNTSGFpOXZhR3lmWTdrTjdsMDk4bzUzQmpZbGRiRjVQZzNwOStLVitv?=
 =?utf-8?B?YTBDWVRLL1FXdTlFR1M1NFJwNklOQ3Y1MDlJbHNyWW02QTBrRkIzcWFNVmRH?=
 =?utf-8?B?MnlNcDJBLzZWMGV2M2czNnlLQVMrQ2xtTzlTeE5yV3JDV1JiN3FGbHM4K1BO?=
 =?utf-8?B?WjJGdGx0MnViamcycXB2NEo4M2dtUEN0NGxKM0QxdXRTN2c4R2wvdnVMZDRT?=
 =?utf-8?B?Kzl0UDh6T2VHMGhaSE9waTNiL0pTSHMwUWUzLzdoVVNQQUxmZHRNazFZUzQ1?=
 =?utf-8?B?T1IyR3c1M0xnZWU3YmVBczU0SUF6SXB4eG9xbU5ocXRCZ21vQVpDMnlGSm9s?=
 =?utf-8?B?bnBQYXc5c1pyb0pZcXBpQUNMWUtpNjRrT3pvWFlzNmlrYWFuRTBnY0NWbk1Q?=
 =?utf-8?B?Ukc3VkJDL3ZKRlZTSThSTHMwWTU4akFsczZ4Z0prL1laeGIxYWZkaHB3YzhU?=
 =?utf-8?B?TURXSklBNUdPVWdnSlp3VTNqb3hlUGxKcGpZMkVuUDAwaXlzdFE4ZW5wZ2FX?=
 =?utf-8?B?bXI4VUlRV1IxaEJpUzdTZ09NRWhsbUlMbnN0eHhmVHdkWW40cFNSUU95d09k?=
 =?utf-8?B?NjVZZ0RmWlliMWd0UDNHdldOWlVJeXlXSnBsbWFyQi9RSnJHY3hyODJ0VUdP?=
 =?utf-8?Q?WZfQk0krqLg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8496.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(8096899003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UTJPWFN4Y3FWREF3KzVEdFZlZGswOHA2czc3T3JTNVl0N1VZMVNiR0FRSXNa?=
 =?utf-8?B?bWdxdG8zeC9YdzZ3dURzRzNMZStDMUlYeGo4dmNXRTNQM0djQ2x4Z3RCUG5z?=
 =?utf-8?B?YzBrYTQrRHFzbGZRWmd2bzVZUGR1VFdhR3VWcGdJTEFuVkpVUksvTE54MUlL?=
 =?utf-8?B?a1pLdmhQQ2QwWkVRNDFHT2hrWG1Ta0h1S0sySzNLT1R4YmRHNnBFVld4REo1?=
 =?utf-8?B?eUpRcHQ0eVNUQnRKc05MRHdoMUp4bGhCK2ZDV2pBU0p5NDd3VWtmalRmaVEw?=
 =?utf-8?B?eWlSZ3I3Ti8yNjVVQTNFeHRmTXV1aCtmQTdnMXY1bU5zM1krMkNqQUduS0Mw?=
 =?utf-8?B?c2M0SG1SQ2lCU0RnVlcrWFByOG9PYmFrSzFuUXVsQWtpYUxoV1cvcWtRaG42?=
 =?utf-8?B?b2lHQ0tKcHNVaWN1VTlGOVp5UUxQSkRYQ1U3UnRlQjhQK1NYYTZoS3BNU2tj?=
 =?utf-8?B?M05HNUh5amxad3pOTUk4emxNajAwVGl2UmNGdnJ0bWxuVXVUR2lMY3ovOTdP?=
 =?utf-8?B?QmJrVzBBS3NqS1JSRGVKZ3ViVGFHSHFWSlp3QnRSemdrWjBYUDZCeVBzdXNz?=
 =?utf-8?B?N0VlWm5UVVRwSmltUUduSE9EL2ZsVWJFSHIrOVBLYTJCeXRUdDlSWXVVblJ5?=
 =?utf-8?B?KzJLYms3UmJrRHBwQzlqaXFsRjc0STFxODhkMitmdnlmblFreEdmVTc1U2Rl?=
 =?utf-8?B?SnNsS0hHQno0ZkFaWlZFYkxoUDBmZEp1VFY0RFhJSGVUM0c5VW5YaDlhM3dZ?=
 =?utf-8?B?OElMbk54UDF4azhsSnVkR3dtUWRoYnFxOFBMYnRqTnF0U1lNWXQyN2kwblNL?=
 =?utf-8?B?d3pzZGNjWDNKQ0lKNU5ZaUlMWDJJWkFtb2VlZWhoZFNnVC9XVDdQSzltMXZ1?=
 =?utf-8?B?S0dlR2wyak5xTHJpWnl4bnh6T2lWUWM2RlVpQ3hmU0ljMjlYWVhWZ1JyalF5?=
 =?utf-8?B?TGp6UUZpam1BYmhEeWF6UCsvb3JQNUplSFkzZFpiWGg1TzRCVm1Ub2pZTzRV?=
 =?utf-8?B?V3pnZ0E5WWFvU1dpTVVxRTlJckZmMU5UY3FWSXFFMTlYeFE0RGhPQk1GSjJv?=
 =?utf-8?B?NExSUzF6eWZsald1Y2NsaHFFSC9Pd1hMVHhWVTZPbEpDaitoTUpvbHBNQmVD?=
 =?utf-8?B?VzJFdEQ5cTNwVzcycWhsLzZrQWlmeUVETWlaM0RyV3NFV3AwVitKa0sra3Nw?=
 =?utf-8?B?MnNabkRFaDZWNC9sNHRySCtiRlNuRHZZU0p2cTh6Y2p1SmNDb0dqTzhFaEJN?=
 =?utf-8?B?YmR6bGtHQmVwaUdzYUk5emNEeXlsR2ZqMlVaUjJFNjVHbnVnUDJFd2tjc3Nl?=
 =?utf-8?B?UmVMWVhJQ0x6WHY3Y0IwVHNPcE5aeTN3VUhQdE42aWRxZWFudjBJSklwRm9o?=
 =?utf-8?B?bHVYSzVoQ09KMGlNNWVaYzdNUXYwVXJiRnNpTDFUcGszTlVpUmVaczdvd1hr?=
 =?utf-8?B?eXJUUSs4NlhOUm1BQnQ3QmRWWUVQREkvTVdhK0UzRzg0djBBQkcwNjR5dndz?=
 =?utf-8?B?cDRCVDZJNzcrcXBiOW5mVEpneDkranM0dTJ4ZUpFbWxOaFE4OFBvODV5czBF?=
 =?utf-8?B?MXZkQUdjQUdvSkIvQzdBdU5XeUF3bkFuWlJGck50SkpBNk9aUi9udzl0M0FC?=
 =?utf-8?B?c3MrVGZYSW5ieWNqZ1k5VFAySHAvR0kzMXVqcEtkblFBK0l1V1BBY1ZKMlZ3?=
 =?utf-8?B?QmFHRE9KZHFReWl1cEloLzJoNmQ2SE5kOThKRlBQa3R4dXcrNzJQUTRPZlFr?=
 =?utf-8?B?U0xOVmRNODZ6MERTL1oxdE9PS2hMZmt1TCs3Sk9OU0c2ZEhQVXBiMnBMTnpX?=
 =?utf-8?B?aXdGT2tHTU1MMndBaUNHSXhBTWxxMy9DTU1ndnBNQ1IzbXE4NlRQbHhyUHRO?=
 =?utf-8?B?UVVLZWdSZE5WdTBmOGJxZFpVd3REbFlNMmlEYXhlV0grcVlYTjdQUWNLeG03?=
 =?utf-8?B?TTJYeFdnUGVmd3JqRG9icDBxQXJ1ZW5ORzc2dlRJWnVLS3A3ZlUxZEpoOUlv?=
 =?utf-8?B?cDhRMXk2Tks1ZjZnSDBxMzlzV0VIdHVwY2tBY0Uvczk0TDZmbTdONDRzeE5E?=
 =?utf-8?B?bWhHYkJneGNIOWVSbEpZa05aaGxUUlhhVTJyb2t0dlUxWmxGbEl6VUhsc1hI?=
 =?utf-8?B?TTcvKy8xWWM2UDJkTUFrVGJHVXhPMy9iS1Z1VThRSklzWlplTU52R0pmWDRH?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00cc6058-643c-48db-3b63-08ddea80bcbd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8496.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 00:28:00.1513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2n1w+4U2qvSqv8sceeRt162Itd+q6r+/y7JODEYwhffkhCkjlswR/S3wWa6BYqa7GTlm4L59S23oTplUwWBP5xTtYEW0w2I1vMPRe9iY9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6469
X-Authority-Analysis: v=2.4 cv=FqYF/3rq c=1 sm=1 tr=0 ts=68b78b93 cx=c_pps
 a=XdZ3Z4l4en2e+C7y5TjdwQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=eEPUR9YtyAHyiH_hA7UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=k-42gJp3AAAA:8 a=-tFoHYRcHnMT_DiyjiIA:9
 a=_gKKjmxbjnD-q4-S:21 a=_W_S_7VecoQA:10 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-GUID: kJSN46sY1C8rcMeNimvery5urj61u7QC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDAwMiBTYWx0ZWRfX2DRBEpNXn3o7
 qrWWRiQg5odnxkyQ75nw5RRActRXGl8IN34epVd1HaaYAagIRHwthp5mEG6njvxDuj29ca2HufV
 iEzD3wD756/Hc3BcllQ6dYL9o1bb0AOAl3Dv0vuhXWvSNjlTirRSiClDTcwlVNTh6gRKPG06ztC
 KURp2EWAYTQHjcBQhT4qDGK13Z7VmEiPJJ32Odonvyvr/fG0iiYb6BOj6Z9zzg2vccFNDnCAB4o
 57jXuPTZjCAIkmg6GX9AjozSgt4xijcKNGx99vsJLin+FOYWQuFXpRtoREXop0fynUGGw/ipE2X
 aC5lMPmKxvNY0PdvTQMk6zGly2Kh6O3uOmzS8ZoFc/bIushhLBkRB93qJPgZN0=
X-Proofpoint-ORIG-GUID: kJSN46sY1C8rcMeNimvery5urj61u7QC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_09,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 03 Sep 2025 00:28:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2119

--------------q0ymE9lKPTmsQZxYfBTFzASA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5826vWE01223092

Hi Scott,


On 2025-09-02 4:56 p.m., Scott Murray wrote:
> On Thu, 28 Aug 2025, Sambu, Soumya wrote:
>
>> Hi Scott and meta-lts-mixins/kirkstone/rust folks,
>>
>> We (Randy and I and others at Wind River) wanted to share our
>> experience with integrating 'meta-lts-mixins/kirkstone/rust' into our
>> kirkstone-based setup to enable support for the latest Chromium versio=
n.
>>
>> While the initial integration showed promise, we encountered several
>> build issues that led us to reconsider. Most of the challenges stemmed
>> from the major upgrade of python3-setuptools and the Rust toolchain,
>> which introduced incompatibilities with several packages in our
>> environment.
>>
>> Here=E2=80=99s a summary of the key issues we faced:
>>
>> Setuptools-related failures:
>> - python3-strict-rfc3339 0.7-r0 =E2=80=93 do_compile failure: ERROR: p=
ython3 setup.py bdist_wheel' execution failed
>> - systemtap =E2=80=93 do_configure failure due to autoconf-related QA =
errors
>> - python3-grpcio =E2=80=93 do_compile failure: distutils.errors.Compil=
eError
>> - python3-awscrt =E2=80=93 do_compile failure: unsafe include path /us=
r/include/python3.10 for cross-compilation
>> - python3-azure-iot-device =E2=80=93 do_compile failure: invalid speci=
fier '!=3D3.3*'
> I don't believe you ever replied to my question about whether these
> failures are all that result from a world build with e.g. meta-python,
> meta-aws, etc.
Yes, most of the problems we encountered were from world builds,
that involved this list of layers: (1)


> If that is the case, to be honest, the fallout of the
> setuptools backport doesn't seem that bad to me, and IMO worst case you
> could always chose to handle them in a WR mixin layer for your customer=
s.

Yes, there were many ways to deal with this, I asked Soumya to focus
on the collective good of getting things fixed in this mixin or other=20
'upstream' layer.


> I did forget to go back and look at systemtap, that's definitely on me,
> and I'll take a poke at it this week.
>
>> Rust-related failures:
>> - Internal BSP: libstd-rs do_compile failure =E2=80=93 Error loading t=
arget
>> specification: 'softfp' is not a valid value for llvm-floatabi
>> - mozjs78 and mozjs-91 =E2=80=93 do_compile failures
>>
>> Thanks to a variety of commits and your work, these issues were
>> resolved. However, we remain concerned about potential customer
>> regressions from introducing higher version packages into our
>> kirkstone-based setup. So, we=E2=80=99ve decided to hold off on using
>> 'meta-lts-mixins/kirkstone/rust' for now to avoid impacting our
>> customers.
>>
>> We appreciate the effort that=E2=80=99s gone into maintaining the mixi=
ns and
>> hope this feedback helps others in the community. We=E2=80=99ll contin=
ue to
>> monitor developments and may make use of this work in customer-specifi=
c
>> projects.
>>
>> Thanks again for your work and support.
> Thanks, I guess?
We really do appreciate you working on this!!


I'm still somewhat disappointed that we've had to drop the effort since
I put quite a bit of time into chromium over the years.

Also, I wanted the rust mixin layer to just work, mostly to convince
myself and RP that Rust's crazy "bug fixes in the new release"
approach wasn't that crazy. From this work at least, the problems

we're NOT with Rust, they were with other packages and build tools.


> I know you've a desire for me to slap your workarounds
> for mozjs and the like into dynamic-layers, but as I reported previousl=
y
> I can't reproduce the failures you're seeing with e.g. python3-grpcio,
> and your tweaks for mozjs seem obsoleted by the last couple of Rust
> updates.

No slapping of work-arounds is desired. We were aiming to do the
right thing and if we fell short, that's on me.


> As others have mentioned, we're about 8 months away from
> kirkstone EOL, so it's impossible for me to justify investing more of
> my time into trying to hack up a frankenstein setuptools-rust that avoi=
ds
> needing the setuptools backport.
I understand and agree with that call.
> That said, I would merge a reasonable
> looking implementation of that if WR is for some reason motivated to
> invest in it, and am also willing to discuss handing over maintainershi=
p
> of the kirkstone/rust mixin if WR plans to support kirkstone for its
> customers past Q2 2026.
Thanks for the explanation and offer. We'll keep it in mind but
our goal was to enable chromium for our kirkstone-based product.
Since we don't have very many customers who are still using chromium=20
from that release, or
chromium in general, really, we've EOLed support for that package.=20
Therefore, unless we find a paying
customer to work with our services team, we won't be doing anything else=20
with

the meta-lts-mixin/rust/kirkstone layer.

Thanks Scott,

../Randy

>
> Scott


1)

BSP and meta-layers used:

amd-x86
aptiv-s32g
axxiaarm
bcm-2xxx-rpi
intel-socfpga
intel-x86
local
marvell-cn106xx
marvell-cn10xxx
marvell-cn9xxx
meta-anaconda
meta-arm
meta-browser
meta-cgl
meta-clang
meta-cloud-services
meta-dpdk
meta-freescale
meta-freescale-distro
meta-gplv2
meta-imx
meta-intel
meta-intel-fpga
meta-intel-qat
meta-iot-cloud
meta-lat
meta-lts-mixins
meta-mingw
meta-openembedded
meta-qoriq
meta-qt6
meta-raspberrypi
meta-realtime
meta-secure-core
meta-security
meta-selinux
meta-tegra
meta-tensorflow
meta-ti
meta-virtualization
meta-xilinx
meta-xilinx-tools
meta-yocto
nvidia-orin
nxp-imx6
nxp-imx7
nxp-imx8
nxp-ls1028
nxp-ls1043
nxp-ls1046
nxp-lx2xxx
nxp-s32g
oe-core
ti-j72xx
ti-j7xxx
wrlinux
wr-ota
wr-sbom
wr-sbom-tools
wr-template
xilinx-versal
xilinx-zynq
xilinx-zynqmp

--=20
# Randy MacLeod
# Wind River Linux

--------------q0ymE9lKPTmsQZxYfBTFzASA
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5826vWE01223092

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">Hi Scott,</div>
    <div class=3D"moz-cite-prefix"><br>
    </div>
    <div class=3D"moz-cite-prefix"><br>
    </div>
    <div class=3D"moz-cite-prefix">On 2025-09-02 4:56 p.m., Scott Murray
      wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:3f3df632-63bd-652b-dba6-4a4a3a6=
a0f93@konsulko.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">On Thu, 28 Aug 2025, Sambu, =
Soumya wrote:

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">Hi Scott and meta-lts-mixi=
ns/kirkstone/rust folks,

We (Randy and I and others at Wind River) wanted to share our
experience with integrating 'meta-lts-mixins/kirkstone/rust' into our
kirkstone-based setup to enable support for the latest Chromium version.

While the initial integration showed promise, we encountered several
build issues that led us to reconsider. Most of the challenges stemmed
from the major upgrade of python3-setuptools and the Rust toolchain,
which introduced incompatibilities with several packages in our
environment.

Here=E2=80=99s a summary of the key issues we faced:

Setuptools-related failures:
- python3-strict-rfc3339 0.7-r0 =E2=80=93 do_compile failure: ERROR: pyth=
on3 setup.py bdist_wheel' execution failed
- systemtap =E2=80=93 do_configure failure due to autoconf-related QA err=
ors
- python3-grpcio =E2=80=93 do_compile failure: distutils.errors.CompileEr=
ror
- python3-awscrt =E2=80=93 do_compile failure: unsafe include path /usr/i=
nclude/python3.10 for cross-compilation
- python3-azure-iot-device =E2=80=93 do_compile failure: invalid specifie=
r '!=3D3.3*'
</pre>
      </blockquote>
      <pre wrap=3D"" class=3D"moz-quote-pre">I don't believe you ever rep=
lied to my question about whether these
failures are all that result from a world build with e.g. meta-python,
meta-aws, etc.  </pre>
    </blockquote>
    Yes, most of the problems we encountered were from world builds, <br>
    that involved this list of layers: (1)<br>
    <br>
    <br>
    <blockquote type=3D"cite" cite=3D"mid:3f3df632-63bd-652b-dba6-4a4a3a6=
a0f93@konsulko.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">If that is the case, to be h=
onest, the fallout of the
setuptools backport doesn't seem that bad to me, and IMO worst case you
could always chose to handle them in a WR mixin layer for your customers.=
</pre>
    </blockquote>
    <p>Yes, there were many ways to deal with this, I asked Soumya to
      focus<br>
      on the collective good of getting things fixed in this mixin or
      other 'upstream' layer.<br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:3f3df632-63bd-652b-dba6-4a4a3a6=
a0f93@konsulko.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">
I did forget to go back and look at systemtap, that's definitely on me,
and I'll take a poke at it this week.</pre>
    </blockquote>
    <blockquote type=3D"cite" cite=3D"mid:3f3df632-63bd-652b-dba6-4a4a3a6=
a0f93@konsulko.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">Rust-related failures:
- Internal BSP: libstd-rs do_compile failure =E2=80=93 Error loading targ=
et
specification: 'softfp' is not a valid value for llvm-floatabi
- mozjs78 and mozjs-91 =E2=80=93 do_compile failures

Thanks to a variety of commits and your work, these issues were
resolved. However, we remain concerned about potential customer
regressions from introducing higher version packages into our
kirkstone-based setup. So, we=E2=80=99ve decided to hold off on using
'meta-lts-mixins/kirkstone/rust' for now to avoid impacting our
customers.

We appreciate the effort that=E2=80=99s gone into maintaining the mixins =
and
hope this feedback helps others in the community. We=E2=80=99ll continue =
to
monitor developments and may make use of this work in customer-specific
projects.

Thanks again for your work and support.
</pre>
      </blockquote>
      <pre wrap=3D"" class=3D"moz-quote-pre">Thanks, I guess?  </pre>
    </blockquote>
    We really do appreciate you working on this!! <br>
    <p><br>
    </p>
    <p>I'm still somewhat disappointed that we've had to drop the effort
      since<br>
      I put quite a bit of time into chromium over the years.<br>
    </p>
    Also, I wanted the rust mixin layer to just work, mostly to convince<=
br>
    myself and RP that Rust's crazy &quot;bug fixes in the new release&qu=
ot; <br>
    approach wasn't that crazy. From this work at least, the problems<br>
    <p>we're NOT with Rust, they were with other packages and build
      tools.</p>
    <p><br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:3f3df632-63bd-652b-dba6-4a4a3a6=
a0f93@konsulko.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">I know you've a desire for m=
e to slap your workarounds
for mozjs and the like into dynamic-layers, but as I reported previously
I can't reproduce the failures you're seeing with e.g. python3-grpcio,
and your tweaks for mozjs seem obsoleted by the last couple of Rust
updates.  </pre>
    </blockquote>
    <p>No slapping of work-arounds is desired. We were aiming to do the<b=
r>
      right thing and if we fell short, that's on me.<br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:3f3df632-63bd-652b-dba6-4a4a3a6=
a0f93@konsulko.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">As others have mentioned, we=
're about 8 months away from
kirkstone EOL, so it's impossible for me to justify investing more of
my time into trying to hack up a frankenstein setuptools-rust that avoids
needing the setuptools backport.  </pre>
    </blockquote>
    I understand and agree with that call.<br>
    <blockquote type=3D"cite" cite=3D"mid:3f3df632-63bd-652b-dba6-4a4a3a6=
a0f93@konsulko.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">That said, I would merge a r=
easonable
looking implementation of that if WR is for some reason motivated to
invest in it, and am also willing to discuss handing over maintainership
of the kirkstone/rust mixin if WR plans to support kirkstone for its
customers past Q2 2026.</pre>
    </blockquote>
    Thanks for the explanation and offer. We'll keep it in mind but <br>
    our goal was to enable chromium for our kirkstone-based product.<br>
    Since we don't have very many customers who are still using chromium
    from that release, or <br>
    chromium in general, really, we've EOLed support for that package.
    Therefore, unless we find a paying<br>
    customer to work with our services team, we won't be doing anything
    else with<br>
    <p>the meta-lts-mixin/rust/kirkstone layer. <br>
    </p>
    <p>Thanks Scott,<br>
    </p>
    <p>../Randy<br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:3f3df632-63bd-652b-dba6-4a4a3a6=
a0f93@konsulko.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">

Scott</pre>
    </blockquote>
    <p><br>
    </p>
    <p>1)<br>
    </p>
    <p>BSP and meta-layers used:<br>
      <br>
      amd-x86&nbsp; &nbsp;<br>
      aptiv-s32g<br>
      axxiaarm<br>
      bcm-2xxx-rpi<br>
      intel-socfpga<br>
      intel-x86<br>
      local <br>
      marvell-cn106xx<br>
      marvell-cn10xxx<br>
      marvell-cn9xxx<br>
      meta-anaconda<br>
      meta-arm&nbsp; &nbsp;<br>
      meta-browser <br>
      meta-cgl<br>
meta-clang&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      &nbsp;<br>
      meta-cloud-services<br>
      meta-dpdk<br>
      meta-freescale<br>
      meta-freescale-distro<br>
      meta-gplv2<br>
      meta-imx<br>
      meta-intel<br>
      meta-intel-fpga<br>
      meta-intel-qat<br>
      meta-iot-cloud<br>
      meta-lat<br>
      meta-lts-mixins<br>
      meta-mingw<br>
      meta-openembedded<br>
      meta-qoriq<br>
      meta-qt6<br>
      meta-raspberrypi<br>
      meta-realtime<br>
      meta-secure-core<br>
      meta-security<br>
      meta-selinux<br>
      meta-tegra<br>
      meta-tensorflow<br>
      meta-ti<br>
      meta-virtualization<br>
      meta-xilinx<br>
      meta-xilinx-tools<br>
      meta-yocto<br>
      nvidia-orin<br>
      nxp-imx6<br>
      nxp-imx7<br>
      nxp-imx8<br>
      nxp-ls1028<br>
      nxp-ls1043<br>
      nxp-ls1046<br>
      nxp-lx2xxx<br>
      nxp-s32g<br>
      oe-core<br>
      ti-j72xx<br>
      ti-j7xxx<br>
      wrlinux<br>
      wr-ota<br>
      wr-sbom<br>
      wr-sbom-tools<br>
      wr-template<br>
      xilinx-versal<br>
      xilinx-zynq<br>
      xilinx-zynqmp<br>
      <br>
    </p>
    <pre class=3D"moz-signature" cols=3D"72">--=20
# Randy MacLeod
# Wind River Linux</pre>
  </body>
</html>

--------------q0ymE9lKPTmsQZxYfBTFzASA--

