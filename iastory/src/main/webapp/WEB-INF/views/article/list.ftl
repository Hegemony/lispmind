<form method="post">
<div class="row-fluid">
	<div class="span3">
	<#list articles as article>
		<div class="row-fluid">
			<div class="span4">
				<h4><a href="${article.authorId}">${article.authorName}</a>:${article.content}</h4></p>
			</div><!--/span-->
		</div><!--/row-->
	</#list>
	</div>
</div><!--/row-->
</form>