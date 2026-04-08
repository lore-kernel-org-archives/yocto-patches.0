Return-Path: <dburgener@linux.microsoft.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149E91073CBF
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 13:55:19 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.106862.1775656509211143137
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 Apr 2026 06:55:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linux.microsoft.com header.s=default header.b=WUf8G80j;
 spf=pass (domain: linux.microsoft.com, ip: 13.77.154.182, mailfrom: dburgener@linux.microsoft.com)
Received: from [192.168.1.13] (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0E08120B6F01
	for <yocto-patches@lists.yoctoproject.org>; Wed,  8 Apr 2026 06:55:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0E08120B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775656508;
	bh=13NqwMmJFweGNxZ5iqQ4hFVLKJl9V3cXhTG5HX6H1Wc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=WUf8G80j6b653lc4ae7bBkcl3NUDmv9AqxiQ1S0tkdYylAGO/M2sg7x9zU+TopeML
	 +1NqdNVeRmj/9/89eEtfDPchh3L5LVPhWcypWCIfIM3L7Ah+JFD1xHGKBQTtrq2dMU
	 sJ+im5w91IScbSSu0YaIE8/wImIgHr6VQBG4+P4A=
Message-ID: <6e98b151-ba93-490b-a913-e191b1fc4c33@linux.microsoft.com>
Date: Wed, 8 Apr 2026 09:55:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo] [PATCH] Only copy xattrs on a rename if
 it's cross-filesystem
To: yocto-patches@lists.yoctoproject.org
References: <189BDB418FBB5474.2478623@lists.yoctoproject.org>
Content-Language: en-US
From: Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <189BDB418FBB5474.2478623@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 Apr 2026 13:55:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3665

On 3/11/2026 1:59 PM, Daniel Burgener via lists.yoctoproject.org wrote:
> On same file-system renames, the path update in the db means that the
> xattrs are already present, and copying results in duplicates.  This was
> previously masked by the bug fixed in d1db9c219abf92f15303486a409292237f1fc790, since that prevented the
> xattr copying.  Now that that bug is fixed, we started observing this
> issue in 1.9.3.
> 
> AI-Generated: Code fix by Claude Haiku 4.5.  Test code by me.
> 
> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
> ---
>   pseudo_db.c        |  4 +++-
>   test/test-xattr.sh | 12 ++++++++++++
>   2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/pseudo_db.c b/pseudo_db.c
> index 9713e0c..6a33f20 100644
> --- a/pseudo_db.c
> +++ b/pseudo_db.c
> @@ -2196,7 +2196,9 @@ pdb_update_inode(pseudo_msg_t *msg) {
>   	found_existing = !pdb_find_file_path(oldmsg);
>   	if (found_existing) {
>   		/* we have an existing file entry */
> -		pdb_copy_xattrs(oldmsg, msg);
> +		if (oldmsg->dev != msg->dev || oldmsg->ino != msg->ino) {
> +			pdb_copy_xattrs(oldmsg, msg);
> +		}
>   	}
>   	sqlite3_bind_int(update, 1, msg->dev);
>   	sqlite3_bind_int64(update, 2, signed_ino(msg->ino));
> diff --git a/test/test-xattr.sh b/test/test-xattr.sh
> index 6ac6b3c..89fbd35 100755
> --- a/test/test-xattr.sh
> +++ b/test/test-xattr.sh
> @@ -65,6 +65,18 @@ then
>       exit 1
>   fi
>   
> +mv f1 f2
> +attrs=`getfattr -d -m - f2 | grep -v '^#'`
> +expected=$'security.dummy="test_f2"\nuser.dummy="test_f1"'
> +if [ "$attrs" != "$expected" ]
> +then
> +	#echo "Fail, unpexected getfattr result '$attrs'"
> +	rm -f f1
> +	rm -f f2
> +	exit 1
> +fi
> +
>   #echo "Passed."
>   rm -f f1
> +rm -f f2
>   exit 0

Gentle ping on this patch.  Any feedback?

-Daniel

