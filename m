Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11353C25B78
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 18:16:14 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
 by mx.groups.io with SMTP id smtpd.web10.29631.1716920168837432651
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 May 2024 11:16:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Gh0Ra11+;
 spf=pass (domain: gmail.com, ip: 209.85.128.181, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-62a2424ec50so10494987b3.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 28 May 2024 11:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716920168; x=1717524968; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fmZtAv51RF+hsOpla7ydgMQaJiBRhBkCbc+jePIUyko=;
        b=Gh0Ra11+Ul/61b3i2T9ELVPprpr5h3bQc431cNskeC2OanqbhlZ6nJ9Nggazt1ADrX
         IIyLepk+pOpDcHCkypA35+mNrQVqIsMUKmLJleKgPD84JHTg5iQMqVgD+FFqGVd6yo1Q
         3IaFVLzOFQwKYH/pfdMURDWhWHsyVBzjdZtTWTB1yvdcjNBdsZwD+Ltph/CNzCttaSmQ
         tcuvKUKiOkuu/dg/XKLbmvT5yNhnpCRnOQzYDj18Q4D9IseNb2EbYzc9PSlbU9fmtuos
         qGXFvNMwbof3l1tavVXybRciWbypvjN/xpPNTLxdd9ltsf0bz0p4svdsAYQK2Gwbvcg0
         CMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716920168; x=1717524968;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmZtAv51RF+hsOpla7ydgMQaJiBRhBkCbc+jePIUyko=;
        b=ZTxCMxI08+E0ZhW3ZPCEriDl/whQTUC/LHO+PtbvMxskzABEdIjpzg7E7gBL+vw+TY
         Q1NBM3GjTcSauE0xP5+w1mbE/AF0wpFRu26QaZFtUF1umbFPui1RoH+Kd4J9/pNyKM0q
         +sfFbOzxs5qorAk81Lkzf0ubwHlLeJW3lAVnCVD5TwrvgWqq9NjZ+sk3+AkaFiFWZ9BQ
         vylarg91gePvwLAihSppTZKB4RYBFG4mumJvP9zCNlNIJ/+bMlpDCkdXsGz+yIOphirz
         QI6ir8Dq2uOkhz1vHxyPepCvF9FdIt4mqvUDHdfw+5ntFQo3e4NVRzYTFFm6VdQd42H5
         16ow==
X-Gm-Message-State: AOJu0YzfhiAOzNCThWKlmAao7CmPy8i2k+TYbzFnhfbAvXxSv0+cOqNe
	Yux3x0Dx01lwKg3HZphEMEJ2rrNPoe53pdtxVy+4piXcMUb/CuD2Fg3Eiw==
X-Google-Smtp-Source: AGHT+IF0FqkShgGt6zYiNSWQlIldtY9CnZ+/RWrcvqrXFgiV/+5lBiQ9DalP6IqZRX1eZSvaANXMEw==
X-Received: by 2002:a81:a04d:0:b0:611:9622:46e7 with SMTP id 00721157ae682-62a08f22ac0mr115629237b3.48.1716920167875;
        Tue, 28 May 2024 11:16:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:45dd:7000:9f87:6ec9:14e6:1b94? ([2600:1700:45dd:7000:9f87:6ec9:14e6:1b94])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a534d03sm21541467b3.122.2024.05.28.11.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 11:16:07 -0700 (PDT)
Message-ID: <ac164a4c-c5be-4b19-ab48-546c0cc269c0@gmail.com>
Date: Tue, 28 May 2024 14:16:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH]
 tcp-smack-test/udp-smack-test: fix do_compile failure
To: changqing.li@windriver.com
References: <20240528054424.4037114-1-changqing.li@windriver.com>
Content-Language: en-US
Cc: yocto-patches@lists.yoctoproject.org
From: akuster808 <akuster808@gmail.com>
Autocrypt: addr=akuster808@gmail.com; keydata=
 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
 ApZ86eOP
In-Reply-To: <20240528054424.4037114-1-changqing.li@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 May 2024 18:16:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/238

  Hello Changging,

Martin sent a patch to fix this earlier.

thanks.
Armin

On 5/28/24 1:44 AM, Changqing Li via lists.yoctoproject.org wrote:
> From: Changqing Li <changqing.li@windriver.com>
>
> Include proper headers to fix following errors:
> | udp_client.c:41:16: error: implicit declaration of function 'atoi' [-Wimplicit-function-declaration]
> |    41 |         port = atoi(argv[1]);
> | udp_client.c:52:12: error: implicit declaration of function 'fsetxattr' [-Wimplicit-function-declaration]
> |    52 |         if(fsetxattr(sock, attr, label, strlen(label),0) < 0)
> |       |            ^~~~~~~~~
> | udp_client.c:67:9: error: implicit declaration of function 'close'; did you mean 'pclose'? [-Wimplicit-function-declaration]
> |    67 |         close(sock);
> |       |         ^~~~~
> |       |         pclose
> | tcp_client.c:55:16: error: implicit declaration of function 'atoi' [-Wimplicit-function-declaration]
> |    55 |         port = atoi(argv[1]);
> ...
>
> Signed-off-by: Changqing Li <changqing.li@windriver.com>
> ---
>   recipes-mac/smack/tcp-smack-test/tcp_client.c | 1 +
>   recipes-mac/smack/tcp-smack-test/tcp_server.c | 3 +++
>   recipes-mac/smack/udp-smack-test/udp_client.c | 3 +++
>   recipes-mac/smack/udp-smack-test/udp_server.c | 3 +++
>   4 files changed, 10 insertions(+)
>
> diff --git a/recipes-mac/smack/tcp-smack-test/tcp_client.c b/recipes-mac/smack/tcp-smack-test/tcp_client.c
> index 6c0a474..b82b575 100644
> --- a/recipes-mac/smack/tcp-smack-test/tcp_client.c
> +++ b/recipes-mac/smack/tcp-smack-test/tcp_client.c
> @@ -18,6 +18,7 @@
>   // OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>   // THE SOFTWARE.
>   #include <stdio.h>
> +#include <stdlib.h>
>   #include <sys/socket.h>
>   #include <sys/types.h>
>   #include <errno.h>
> diff --git a/recipes-mac/smack/tcp-smack-test/tcp_server.c b/recipes-mac/smack/tcp-smack-test/tcp_server.c
> index 3c8921f..6de7ccd 100644
> --- a/recipes-mac/smack/tcp-smack-test/tcp_server.c
> +++ b/recipes-mac/smack/tcp-smack-test/tcp_server.c
> @@ -24,6 +24,9 @@
>   #include <netinet/in.h>
>   #include <unistd.h>
>   #include <string.h>
> +#include <stdlib.h>
> +#include <sys/xattr.h>
> +
>   
>   int main(int argc, char* argv[])
>   {
> diff --git a/recipes-mac/smack/udp-smack-test/udp_client.c b/recipes-mac/smack/udp-smack-test/udp_client.c
> index 23f3e00..3d2ee31 100644
> --- a/recipes-mac/smack/udp-smack-test/udp_client.c
> +++ b/recipes-mac/smack/udp-smack-test/udp_client.c
> @@ -19,6 +19,9 @@
>   // THE SOFTWARE.
>   #include <sys/socket.h>
>   #include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <sys/xattr.h>
>   #include <netinet/in.h>
>   #include <netdb.h>
>   #include <string.h>
> diff --git a/recipes-mac/smack/udp-smack-test/udp_server.c b/recipes-mac/smack/udp-smack-test/udp_server.c
> index 7d2fcf5..25ad1ef 100644
> --- a/recipes-mac/smack/udp-smack-test/udp_server.c
> +++ b/recipes-mac/smack/udp-smack-test/udp_server.c
> @@ -22,6 +22,9 @@
>   #include <netinet/in.h>
>   #include <netdb.h>
>   #include <string.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <sys/xattr.h>
>   
>   int main(int argc, char* argv[])
>   {


