$('#search-form').submit ->
	getSearch()

getSearch = ->
	$.ajax
		type: 'GET'
		url: "/#{$('#select-search').val()}"
		data: 
			query: $('#query-input').val()
		success: (data)->
			console.log(data)
			successCallBack(data)
			$('#searchModel').foundation('reveal', 'open');
	return false

successCallBack = (data)->
	path = $('#select-search').val()
	if path == 'users' then usersPopulateUL(data)
	if path == 'groups' then groupsPopulateUL(data)
	false

usersPopulateUL = (data)->
	items = []
	$.each data, (i, item)->
		items.push("<li><a href='/users/#{item.id}'>#{item.name}</a></li>")
	$('#search-results').empty().append(items.join(''))

groupsPopulateUL = (data)->
	items = []
	$.each data, (i, item)->
		items.push("<li><a href='/groups/#{item.id}'>#{item.name}</a></li>")
	$('#search-results').empty().append(items.join(''))