Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web10.9567.1712774718365985514
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Apr 2024 11:45:18 -0700
Message-ID: <8437f5e9-eff1-4fbc-af02-8d63575943b0@kernel.crashing.org>
Date: Wed, 10 Apr 2024 13:44:14 -0500
MIME-Version: 1.0
Subject: Re: [PATCH] README: Further improve the information about sending patches
References: <20240410173012.2051694-1-richard.purdie@linuxfoundation.org>
From: "Mark Hatle" <mark.hatle@kernel.crashing.org>
In-Reply-To: <20240410173012.2051694-1-richard.purdie@linuxfoundation.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Richard Purdie <richard.purdie@linuxfoundation.org>, yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net
List-ID: <yocto-patches.lists.yoctoproject.org>

Ack.  Looks good to me.

Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>

On 4/10/24 12:30 PM, Richard Purdie wrote:
> Add the git config commands needed to correctly/more easily send patches.
> 
> Also tweak the description and mention who the current nominal maintainers
> are.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   README | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/README b/README
> index 425ee6e..c4cb997 100644
> --- a/README
> +++ b/README
> @@ -1,8 +1,8 @@
> -pseudo -- an analogue to sudo
> +pseudo -- an analogue to sudo and an alternative to fakeroot
>   
>   The official home for pseudo's git repository is:
>   
> -	git://git.yoctoproject.org/pseudo
> +	https://git.yoctoproject.org/pseudo
>   
>   OVERVIEW:
>   
> @@ -70,6 +70,7 @@ commentary.
>   
>   ACKNOWLEDGEMENTS:
>   
> +Peter Seebach:
>   My various coworkers, both engineering and management, made this possible.
>   While I did most of the actual typing, this code has benefitted greatly
>   from detailed code reviews, excellent reproducers for bugs, and the
> @@ -78,8 +79,19 @@ deal of fun, and I'm pretty happy that we're finally ready to make it
>   available for other people to look at.
>   
>   
> +MAINTAINERS:
> +
> +Richard Purdie
> +Mark Hatle
> +
> +
>   CONTACT:
>   
>   Patches should be directed at the yocto-patches mailing list at yocto-patches
> -at lists.yoctoproject.org.  Bugs should be filed with the Yocto project
> -at https://bugzilla.yoctoproject.org/.
> +at lists.yoctoproject.org with [pseudo] in the subject line.  Bugs should be
> +filed with the Yocto project at https://bugzilla.yoctoproject.org/.
> +
> +The repository can be configured to do this correctly with:
> +
> +  git config format.subjectprefix "pseudo] [PATCH"
> +  git config sendemail.to yocto-patches@lists.yoctoproject.org
