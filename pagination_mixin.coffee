#App = require 'app'
#
#App.PaginationMixin = Ember.Mixin.create
#
	page: 1
	perPage: 10

	showPagination: Em.computed.gt('pages', 1)
	lastPage: Em.computed.alias('pages')


	hasPrevious: (->
		@get('page') > 1
	).property('page')

	hasNext: (->
		@get('page') + 1 <= @get('pages')
	).property('page')


	searchByPerPage: (->
		@set('page',1)
#		@evaluateSuccess()
	).observes('perPage')

	visiblePages: (->
		pages = @get('pages')
		page = @get('page')
		limit = 5
		limit = pages if pages < 5
		finish = (start, limit)-> start + (limit - 1)
		start = page - parseInt(limit / 2)
		start = pages - (limit - 1) if finish(start, limit) > pages
		start = 1 if start < 1
		[start..finish(start, limit)]
	).property('page', 'pages')

	showBeforeElipsis: (->
		@get('visiblePages.firstObject') > 1
	).property('visiblePages')

	showAfterElipsis: (->
		Math.abs(@get('lastPage') - @get('visiblePages.lastObject')) > 1
	).property('visiblePages', 'lastPage')


	actions:
		goToNextPage: ->
			@incrementProperty('page') if @get('hasNext')
#			@evaluateSuccess()

		goToPreviousPage: ->
			@decrementProperty('page') if @get('hasPrevious')
#			@evaluateSuccess()

		goToPage: (pageNumber)->
			@set('page', pageNumber) if pageNumber >= 1 && pageNumber <= @get('lastPage')
#sta

